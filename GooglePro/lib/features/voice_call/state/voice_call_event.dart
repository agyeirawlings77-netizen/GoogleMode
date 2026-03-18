import 'package:equatable/equatable.dart';
abstract class VoiceCallEvent extends Equatable {
  const VoiceCallEvent();
  @override List<Object?> get props => [];
}
class StartCallEvent extends VoiceCallEvent {
  final String targetDeviceId;
  final String targetName;
  const StartCallEvent({required this.targetDeviceId, required this.targetName});
  @override List<Object?> get props => [targetDeviceId];
}
class AcceptCallEvent extends VoiceCallEvent { const AcceptCallEvent(); }
class RejectCallEvent extends VoiceCallEvent { const RejectCallEvent(); }
class EndCallEvent extends VoiceCallEvent { const EndCallEvent(); }
class ToggleMuteEvent extends VoiceCallEvent { const ToggleMuteEvent(); }
class ToggleSpeakerEvent extends VoiceCallEvent { const ToggleSpeakerEvent(); }
class IncomingCallEvent extends VoiceCallEvent {
  final String callerId;
  final String callerName;
  const IncomingCallEvent({required this.callerId, required this.callerName});
  @override List<Object?> get props => [callerId];
}
