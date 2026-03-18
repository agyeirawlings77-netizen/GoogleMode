import 'package:equatable/equatable.dart';
import '../model/call_model.dart';
abstract class CallState extends Equatable {
  const CallState();
  @override List<Object?> get props => [];
}
class CallIdle extends CallState { const CallIdle(); }
class CallRinging extends CallState {
  final CallModel call;
  const CallRinging(this.call);
  @override List<Object?> get props => [call.callId];
}
class CallConnecting extends CallState { const CallConnecting(); }
class CallActive extends CallState {
  final CallModel call;
  const CallActive(this.call);
  @override List<Object?> get props => [call.callId, call.isMuted, call.isSpeakerOn];
  CallActive copyWith({bool? isMuted, bool? isSpeakerOn}) => CallActive(call.copyWith(isMuted: isMuted, isSpeakerOn: isSpeakerOn));
}
class CallEnded extends CallState {
  final Duration duration;
  const CallEnded(this.duration);
  @override List<Object?> get props => [duration];
}
class CallDeclined extends CallState { const CallDeclined(); }

extension on CallModel {
  CallModel copyWith({bool? isMuted, bool? isSpeakerOn}) => CallModel(callId: callId, callerId: callerId, callerName: callerName, callerAvatar: callerAvatar, receiverId: receiverId, status: status, direction: direction, startedAt: startedAt, connectedAt: connectedAt, endedAt: endedAt, isMuted: isMuted ?? this.isMuted, isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn);
}
