import 'package:equatable/equatable.dart';
import '../model/voice_call_model.dart';

abstract class VoiceCallState extends Equatable {
  const VoiceCallState();
  @override List<Object?> get props => [];
}
class VoiceCallIdle extends VoiceCallState { const VoiceCallIdle(); }
class VoiceCallCalling extends VoiceCallState {
  final String targetName;
  const VoiceCallCalling(this.targetName);
  @override List<Object?> get props => [targetName];
}
class VoiceCallRinging extends VoiceCallState {
  final String callerName;
  const VoiceCallRinging(this.callerName);
  @override List<Object?> get props => [callerName];
}
class VoiceCallActive extends VoiceCallState {
  final VoiceCallModel call;
  const VoiceCallActive(this.call);
  @override List<Object?> get props => [call.callId, call.isMuted, call.isSpeakerOn];
}
class VoiceCallEnded extends VoiceCallState {
  final Duration duration;
  const VoiceCallEnded(this.duration);
  @override List<Object?> get props => [duration];
}
class VoiceCallError extends VoiceCallState {
  final String message;
  const VoiceCallError(this.message);
  @override List<Object?> get props => [message];
}
