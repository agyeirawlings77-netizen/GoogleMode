import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../service/voice_call_service.dart';
import '../model/call_model.dart';
import '../state/call_state.dart';
import '../state/call_event.dart';
import '../../../core/utils/app_logger.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final VoiceCallService _svc;
  CallModel? _currentCall;
  Timer? _durationTimer;

  CallBloc(this._svc) : super(const CallIdle()) {
    on<StartCallEvent>(_onStart);
    on<EndCallEvent>(_onEnd);
    on<ToggleMuteEvent>(_onToggleMute);
    on<ToggleSpeakerEvent>(_onToggleSpeaker);
    on<AcceptCallEvent>((e, emit) async { await _svc.startAudioStream(); emit(CallActive(_currentCall!)); });
    on<DeclineCallEvent>((e, emit) { _svc.endCall(); emit(const CallDeclined()); });
  }

  Future<void> _onStart(StartCallEvent e, Emitter<CallState> emit) async {
    emit(const CallConnecting());
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final name = FirebaseAuth.instance.currentUser?.displayName ?? 'Me';
      _currentCall = CallModel(callId: const Uuid().v4(), callerId: uid, callerName: name, receiverId: e.deviceId, status: CallStatus.connecting, direction: CallDirection.outgoing, startedAt: DateTime.now());
      await _svc.startAudioStream();
      _currentCall = CallModel(callId: _currentCall!.callId, callerId: _currentCall!.callerId, callerName: _currentCall!.callerName, receiverId: _currentCall!.receiverId, status: CallStatus.active, direction: _currentCall!.direction, startedAt: _currentCall!.startedAt, connectedAt: DateTime.now());
      emit(CallActive(_currentCall!));
      AppLogger.info('Voice call active to ${e.deviceId}');
    } catch (err) { AppLogger.error('Call start failed', err); emit(const CallIdle()); }
  }

  Future<void> _onEnd(EndCallEvent e, Emitter<CallState> emit) async {
    final duration = _currentCall?.duration ?? Duration.zero;
    _durationTimer?.cancel();
    await _svc.endCall();
    _currentCall = null;
    emit(CallEnded(duration));
  }

  void _onToggleMute(ToggleMuteEvent e, Emitter<CallState> emit) {
    _svc.toggleMute();
    if (state is CallActive) emit(CallActive((_currentCall = _currentCall?.copyWith(isMuted: _svc.isMuted)) ?? _currentCall!));
  }

  void _onToggleSpeaker(ToggleSpeakerEvent e, Emitter<CallState> emit) {
    _svc.toggleSpeaker();
    if (state is CallActive) emit(CallActive((_currentCall = _currentCall?.copyWith(isSpeakerOn: _svc.isSpeakerOn)) ?? _currentCall!));
  }

  CallModel? _currentCallCopy(CallModel? base, {bool? isMuted, bool? isSpeakerOn}) => base == null ? null : CallModel(callId: base.callId, callerId: base.callerId, callerName: base.callerName, receiverId: base.receiverId, status: base.status, direction: base.direction, startedAt: base.startedAt, connectedAt: base.connectedAt, isMuted: isMuted ?? base.isMuted, isSpeakerOn: isSpeakerOn ?? base.isSpeakerOn);

  @override Future<void> close() async { await _svc.endCall(); return super.close(); }
}

extension _CMExt on CallModel {
  CallModel copyWith({bool? isMuted, bool? isSpeakerOn}) => CallModel(callId: callId, callerId: callerId, callerName: callerName, receiverId: receiverId, status: status, direction: direction, startedAt: startedAt, connectedAt: connectedAt, isMuted: isMuted ?? this.isMuted, isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn);
}
