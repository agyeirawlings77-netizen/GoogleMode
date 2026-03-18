import 'package:equatable/equatable.dart';
abstract class WebRtcEvent extends Equatable {
  const WebRtcEvent();
  @override List<Object?> get props => [];
}
class StartScreenShareEvent extends WebRtcEvent {
  final String targetDeviceId;
  const StartScreenShareEvent(this.targetDeviceId);
  @override List<Object?> get props => [targetDeviceId];
}
class JoinSessionEvent extends WebRtcEvent {
  final String fromDeviceId;
  final Map<String, dynamic> offerData;
  const JoinSessionEvent({required this.fromDeviceId, required this.offerData});
  @override List<Object?> get props => [fromDeviceId];
}
class EndSessionEvent extends WebRtcEvent { const EndSessionEvent(); }
class IncomingCallEvent extends WebRtcEvent {
  final String fromDeviceId;
  final Map<String, dynamic> offerData;
  const IncomingCallEvent({required this.fromDeviceId, required this.offerData});
  @override List<Object?> get props => [fromDeviceId];
}
class AcceptCallEvent extends WebRtcEvent { const AcceptCallEvent(); }
class RejectCallEvent extends WebRtcEvent { const RejectCallEvent(); }
class ToggleMicEvent extends WebRtcEvent { const ToggleMicEvent(); }
class ToggleCameraEvent extends WebRtcEvent { const ToggleCameraEvent(); }
