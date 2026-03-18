import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../service/voice_call_service.dart';
import '../model/voice_call_model.dart';
import '../state/voice_call_state.dart';
import '../state/voice_call_event.dart';

class VoiceCallBloc extends Bloc<VoiceCallEvent, VoiceCallState> {
  final VoiceCallService _service;
  VoiceCallModel? _currentCall;
  StreamSubscription? _durationSub;

  VoiceCallBloc(this._service) : super(const VoiceCallIdle()) {
    on<StartCallEvent>(_onStart);
    on<AcceptCallEvent>(_onAccept);
    on<RejectCallEvent>(_onReject);
    on<EndCallEvent>(_onEnd);
    on<ToggleMuteEvent>(_onToggleMute);
    on<ToggleSpeakerEvent>(_onToggleSpeaker);
    on<IncomingCallEvent>(_onIncoming);
  }

  String get _myUid => FirebaseAuth.instance.currentUser?.uid ?? '';
  String get _myName => FirebaseAuth.instance.currentUser?.displayName ?? 'Me';

  Future<void> _onStart(StartCallEvent e, Emitter<VoiceCallState> emit) async {
    emit(VoiceCallCalling(e.targetName));
    try {
      await _service.startCall();
      _currentCall = VoiceCallModel(callId: const Uuid().v4(), callerId: _myUid, callerName: _myName, receiverId: e.targetDeviceId, receiverName: e.targetName, status: CallStatus.active, startedAt: DateTime.now());
      emit(VoiceCallActive(_currentCall!));
    } catch (e) { emit(VoiceCallError(e.toString())); }
  }

  void _onIncoming(IncomingCallEvent e, Emitter<VoiceCallState> emit) => emit(VoiceCallRinging(e.callerName));

  Future<void> _onAccept(AcceptCallEvent e, Emitter<VoiceCallState> emit) async {
    try {
      await _service.startCall();
      if (_currentCall != null) emit(VoiceCallActive(_currentCall!));
    } catch (e) { emit(VoiceCallError(e.toString())); }
  }

  void _onReject(RejectCallEvent e, Emitter<VoiceCallState> emit) => emit(const VoiceCallIdle());

  Future<void> _onEnd(EndCallEvent e, Emitter<VoiceCallState> emit) async {
    final duration = _currentCall?.duration ?? Duration.zero;
    await _service.endCall();
    _currentCall = null;
    emit(VoiceCallEnded(duration));
  }

  void _onToggleMute(ToggleMuteEvent e, Emitter<VoiceCallState> emit) {
    _service.toggleMute();
    if (_currentCall != null && state is VoiceCallActive) {
      _currentCall!.isMuted = _service.isMuted;
      emit(VoiceCallActive(_currentCall!));
    }
  }

  void _onToggleSpeaker(ToggleSpeakerEvent e, Emitter<VoiceCallState> emit) {
    _service.toggleSpeaker();
    if (_currentCall != null && state is VoiceCallActive) {
      _currentCall!.isSpeakerOn = _service.isSpeakerOn;
      emit(VoiceCallActive(_currentCall!));
    }
  }

  @override Future<void> close() { _durationSub?.cancel(); _service.endCall(); return super.close(); }
}
