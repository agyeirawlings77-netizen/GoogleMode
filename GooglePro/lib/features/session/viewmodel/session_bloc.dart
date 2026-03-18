import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../webrtc/service/webrtc_service.dart';
import '../../webrtc/model/webrtc_state.dart';
import '../../signaling/service/signaling_service.dart';
import '../state/session_bloc_state.dart';
import '../state/session_bloc_event.dart';
import '../../../core/utils/app_logger.dart';

class SessionBloc extends Bloc<SessionBlocEvent, SessionBlocState> {
  final WebRtcService _webRtc;
  final SignalingService _signaling;
  StreamSubscription? _webRtcStateSub;
  StreamSubscription? _candidateSub;
  StreamSubscription? _signalSub;
  String? _sessionId;
  String? _remoteUid;

  SessionBloc(this._webRtc, this._signaling) : super(const SessionIdle()) {
    on<StartSessionEvent>(_onStart);
    on<EndSessionEvent>(_onEnd);
    on<WebRtcStateChangedEvent>(_onWebRtcState);
    on<ToggleVideoEvent>(_onToggleVideo);
    on<ToggleAudioEvent>(_onToggleAudio);
    on<AcceptIncomingSessionEvent>(_onAcceptIncoming);
    on<RemoteSdpReceivedEvent>(_onRemoteSdp);
    on<RemoteCandidateReceivedEvent>(_onRemoteCandidate);
    on<UpdateStatsEvent>(_onStats);
  }

  String get _myUid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _onStart(StartSessionEvent e, Emitter<SessionBlocState> emit) async {
    emit(SessionConnecting(deviceName: e.targetDeviceName, deviceId: e.targetDeviceId));
    try {
      _sessionId = const Uuid().v4();
      _remoteUid = e.targetOwnerUid;

      await _webRtc.initialize();
      await _webRtc.createPeerConnection();

      // Listen for WebRTC state changes
      _webRtcStateSub = _webRtc.stateStream.listen((s) => add(WebRtcStateChangedEvent(s)));

      // Listen for ICE candidates to send to remote
      _candidateSub = _webRtc.candidateStream.listen((c) {
        _signaling.sendCandidate(_remoteUid!, {'candidate': c.candidate, 'sdpMid': c.sdpMid, 'sdpMLineIndex': c.sdpMLineIndex});
      });

      // Listen for incoming signals
      _signalSub = _signaling.incoming.listen((msg) {
        switch (msg.type) {
          case SignalingMessageType.answer:
            if (msg.payload != null) add(RemoteSdpReceivedEvent(sdp: msg.payload!['sdp'] as Map<String, dynamic>, type: 'answer'));
            break;
          case SignalingMessageType.candidate:
            if (msg.payload != null) add(RemoteCandidateReceivedEvent(msg.payload!['candidate'] as Map<String, dynamic>));
            break;
          case SignalingMessageType.bye:
            add(const EndSessionEvent(reason: 'Remote ended session'));
            break;
          default: break;
        }
      });

      // Start screen capture or audio
      if (e.asHost) {
        await _webRtc.startScreenCapture();
      } else {
        await _webRtc.startAudioOnly();
      }

      // Create and send offer
      final offer = await _webRtc.createOffer();
      await _signaling.sendOffer(_remoteUid!, {'sdp': offer.sdp, 'type': offer.type});
      AppLogger.info('Session started: $_sessionId → ${e.targetDeviceId}');
    } catch (err, s) {
      AppLogger.error('Session start failed', err, s);
      emit(SessionError(err.toString()));
    }
  }

  Future<void> _onEnd(EndSessionEvent e, Emitter<SessionBlocState> emit) async {
    await _cleanup();
    emit(SessionEnded(reason: e.reason));
    AppLogger.info('Session ended: ${e.reason}');
  }

  Future<void> _onWebRtcState(WebRtcStateChangedEvent e, Emitter<SessionBlocState> emit) async {
    if (state is SessionActive) {
      emit((state as SessionActive).copyWith(webRtcState: e.state));
    } else if (e.state == WebRtcConnectionState.connected && state is SessionConnecting) {
      final s = state as SessionConnecting;
      emit(SessionActive(sessionId: _sessionId!, deviceId: s.deviceId, deviceName: s.deviceName, webRtcState: e.state));
    } else if (e.state == WebRtcConnectionState.failed) {
      emit(const SessionError('Connection failed'));
    }
  }

  void _onToggleVideo(ToggleVideoEvent e, Emitter<SessionBlocState> emit) {
    if (state is SessionActive) {
      final s = state as SessionActive;
      _webRtc.setVideoEnabled(!s.videoEnabled);
      emit(s.copyWith(videoEnabled: !s.videoEnabled));
    }
  }

  void _onToggleAudio(ToggleAudioEvent e, Emitter<SessionBlocState> emit) {
    if (state is SessionActive) {
      final s = state as SessionActive;
      _webRtc.setAudioEnabled(!s.audioEnabled);
      emit(s.copyWith(audioEnabled: !s.audioEnabled));
    }
  }

  Future<void> _onAcceptIncoming(AcceptIncomingSessionEvent e, Emitter<SessionBlocState> emit) async {
    emit(SessionConnecting(deviceName: e.fromUid, deviceId: e.fromUid));
    try {
      _remoteUid = e.fromUid;
      _sessionId = const Uuid().v4();
      await _webRtc.initialize();
      await _webRtc.createPeerConnection();
      _webRtcStateSub = _webRtc.stateStream.listen((s) => add(WebRtcStateChangedEvent(s)));
      _candidateSub = _webRtc.candidateStream.listen((c) {
        _signaling.sendCandidate(_remoteUid!, {'candidate': c.candidate, 'sdpMid': c.sdpMid, 'sdpMLineIndex': c.sdpMLineIndex});
      });
      await _webRtc.setRemoteDescription(e.sdp);
      final answer = await _webRtc.createAnswer();
      await _signaling.sendAnswer(_remoteUid!, {'sdp': answer.sdp, 'type': answer.type});
    } catch (err) { emit(SessionError(err.toString())); }
  }

  Future<void> _onRemoteSdp(RemoteSdpReceivedEvent e, Emitter<SessionBlocState> emit) async {
    try { await _webRtc.setRemoteDescription(e.sdp); }
    catch (err) { AppLogger.error('Set remote SDP failed', err); }
  }

  Future<void> _onRemoteCandidate(RemoteCandidateReceivedEvent e, Emitter<SessionBlocState> emit) async {
    try { await _webRtc.addIceCandidate(e.candidate); }
    catch (err) { AppLogger.warning('Add ICE candidate failed: $err'); }
  }

  void _onStats(UpdateStatsEvent e, Emitter<SessionBlocState> emit) {
    if (state is SessionActive) emit((state as SessionActive).copyWith(stats: e.stats));
  }

  Future<void> _cleanup() async {
    await _webRtcStateSub?.cancel();
    await _candidateSub?.cancel();
    await _signalSub?.cancel();
    if (_remoteUid != null) await _signaling.sendBye(_remoteUid!);
    await _webRtc.close();
    _sessionId = null;
    _remoteUid = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}

// Re-export enum for convenience
typedef SignalingMessageType = dynamic;
