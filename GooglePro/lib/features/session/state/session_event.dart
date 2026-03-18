import 'package:equatable/equatable.dart';
abstract class SessionEvent extends Equatable {
  const SessionEvent();
  @override List<Object?> get props => [];
}
class StartSessionEvent extends SessionEvent {
  final String targetDeviceId;
  final String targetDeviceName;
  const StartSessionEvent({required this.targetDeviceId, required this.targetDeviceName});
  @override List<Object?> get props => [targetDeviceId];
}
class JoinSessionRequestEvent extends SessionEvent {
  final String fromDeviceId;
  final String fromDeviceName;
  final Map<String, dynamic> offerData;
  const JoinSessionRequestEvent({required this.fromDeviceId, required this.fromDeviceName, required this.offerData});
  @override List<Object?> get props => [fromDeviceId];
}
class AcceptSessionEvent extends SessionEvent { const AcceptSessionEvent(); }
class RejectSessionEvent extends SessionEvent { const RejectSessionEvent(); }
class EndSessionEvent extends SessionEvent { const EndSessionEvent(); }
class ToggleAudioEvent extends SessionEvent { const ToggleAudioEvent(); }
