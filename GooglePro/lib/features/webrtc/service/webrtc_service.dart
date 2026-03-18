import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/webrtc_config.dart';
import '../model/webrtc_state.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class WebRtcService {
  RTCPeerConnection? _pc;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RTCVideoRenderer? _localRenderer;
  RTCVideoRenderer? _remoteRenderer;
  WebRtcConnectionState _state = WebRtcConnectionState.idle;
  final _stateCtrl = StreamController<WebRtcConnectionState>.broadcast();
  final _remoteStreamCtrl = StreamController<MediaStream?>.broadcast();
  final _candidateCtrl = StreamController<RTCIceCandidate>.broadcast();
  final _sdpCtrl = StreamController<RTCSessionDescription>.broadcast();

  Stream<WebRtcConnectionState> get stateStream => _stateCtrl.stream;
  Stream<MediaStream?> get remoteStream => _remoteStreamCtrl.stream;
  Stream<RTCIceCandidate> get candidateStream => _candidateCtrl.stream;
  WebRtcConnectionState get state => _state;
  RTCVideoRenderer? get localRenderer => _localRenderer;
  RTCVideoRenderer? get remoteRenderer => _remoteRenderer;
  MediaStream? get localStream => _localStream;

  Future<void> initialize() async {
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    await _localRenderer!.initialize();
    await _remoteRenderer!.initialize();
    AppLogger.info('WebRTC renderers initialized');
  }

  Future<RTCPeerConnection> createPeerConnection() async {
    _pc = await createPeerConnection(WebRtcConfig.iceServers);
    _pc!.onIceCandidate = (c) { if (c.candidate != null) _candidateCtrl.add(c); };
    _pc!.onIceConnectionState = (s) {
      AppLogger.info('ICE: $s');
      switch (s) {
        case RTCIceConnectionState.RTCIceConnectionStateConnected: _setState(WebRtcConnectionState.connected); break;
        case RTCIceConnectionState.RTCIceConnectionStateDisconnected: _setState(WebRtcConnectionState.reconnecting); break;
        case RTCIceConnectionState.RTCIceConnectionStateFailed: _setState(WebRtcConnectionState.failed); break;
        case RTCIceConnectionState.RTCIceConnectionStateClosed: _setState(WebRtcConnectionState.closed); break;
        default: break;
      }
    };
    _pc!.onTrack = (e) {
      if (e.streams.isNotEmpty) {
        _remoteStream = e.streams[0];
        _remoteRenderer?.srcObject = _remoteStream;
        _remoteStreamCtrl.add(_remoteStream);
        AppLogger.info('Remote track received: ${e.track.kind}');
      }
    };
    _setState(WebRtcConnectionState.initializing);
    return _pc!;
  }

  Future<RTCSessionDescription> createOffer() async {
    final offer = await _pc!.createOffer(WebRtcConfig.sdpConstraints);
    await _pc!.setLocalDescription(offer);
    _sdpCtrl.add(offer);
    AppLogger.info('Offer created');
    return offer;
  }

  Future<RTCSessionDescription> createAnswer() async {
    final answer = await _pc!.createAnswer(WebRtcConfig.sdpConstraints);
    await _pc!.setLocalDescription(answer);
    _sdpCtrl.add(answer);
    AppLogger.info('Answer created');
    return answer;
  }

  Future<void> setRemoteDescription(Map<String, dynamic> sdpMap) => _pc!.setRemoteDescription(RTCSessionDescription(sdpMap['sdp'] as String, sdpMap['type'] as String));
  Future<void> addIceCandidate(Map<String, dynamic> c) => _pc!.addCandidate(RTCIceCandidate(c['candidate'] as String, c['sdpMid'] as String?, c['sdpMLineIndex'] as int?));

  Future<MediaStream> startScreenCapture() async {
    final stream = await navigator.mediaDevices.getDisplayMedia({'video': true, 'audio': false});
    _localStream = stream;
    _localRenderer?.srcObject = stream;
    stream.getTracks().forEach((t) => _pc?.addTrack(t, stream));
    return stream;
  }

  Future<MediaStream> startAudioOnly() async {
    final stream = await navigator.mediaDevices.getUserMedia({'video': false, 'audio': WebRtcConfig.audioConstraints});
    _localStream = stream;
    stream.getAudioTracks().forEach((t) => _pc?.addTrack(t, stream));
    return stream;
  }

  void setVideoEnabled(bool v) => _localStream?.getVideoTracks().forEach((t) => t.enabled = v);
  void setAudioEnabled(bool v) => _localStream?.getAudioTracks().forEach((t) => t.enabled = v);

  Future<void> close() async {
    _localStream?.getTracks().forEach((t) => t.stop());
    await _localStream?.dispose();
    _localStream = null;
    await _remoteStream?.dispose();
    _remoteStream = null;
    _localRenderer?.srcObject = null;
    _remoteRenderer?.srcObject = null;
    await _pc?.close();
    _pc = null;
    _setState(WebRtcConnectionState.closed);
    AppLogger.info('WebRTC closed');
  }

  void _setState(WebRtcConnectionState s) { _state = s; _stateCtrl.add(s); }

  void dispose() {
    close();
    _localRenderer?.dispose();
    _remoteRenderer?.dispose();
    _stateCtrl.close();
    _remoteStreamCtrl.close();
    _candidateCtrl.close();
    _sdpCtrl.close();
  }
}
