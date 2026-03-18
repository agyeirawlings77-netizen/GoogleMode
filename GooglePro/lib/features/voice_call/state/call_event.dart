import 'package:equatable/equatable.dart';
abstract class CallEvent extends Equatable {
  const CallEvent();
  @override List<Object?> get props => [];
}
class StartCallEvent extends CallEvent {
  final String deviceId; final String deviceName;
  const StartCallEvent({required this.deviceId, required this.deviceName});
  @override List<Object?> get props => [deviceId];
}
class EndCallEvent extends CallEvent { const EndCallEvent(); }
class ToggleMuteEvent extends CallEvent { const ToggleMuteEvent(); }
class ToggleSpeakerEvent extends CallEvent { const ToggleSpeakerEvent(); }
class AcceptCallEvent extends CallEvent { const AcceptCallEvent(); }
class DeclineCallEvent extends CallEvent { const DeclineCallEvent(); }
