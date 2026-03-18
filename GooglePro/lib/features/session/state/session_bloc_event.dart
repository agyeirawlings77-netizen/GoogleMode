import 'package:equatable/equatable.dart';
import '../../webrtc/model/webrtc_state.dart';

abstract class SessionBlocEvent extends Equatable {
  const SessionBlocEvent();
  @override List<Object?> get props => [];
}
class StartSessionEvent extends SessionBlocEvent {
  final String targetDeviceId;
  final String targetDeviceName;
  final String targetOwnerUid;
  final bool asHost;
  const StartSessionEvent({required this.targetDeviceId, required this.targetDeviceName, required this.targetOwnerUid, this.asHost = false});
  @override List<Object?> get props => [targetDeviceId];
}
class EndSessionEvent extends SessionBlocEvent {
  final String reason;
  const EndSessionEvent({this.reason = 'User ended'});
}
class WebRtcStateChangedEvent extends SessionBlocEvent {
  final WebRtcConnectionState state;
  const WebRtcStateChangedEvent(this.state);
  @override List<Object?> get props => [state];
}
class ToggleVideoEvent extends SessionBlocEvent { const ToggleVideoEvent(); }
class ToggleAudioEvent extends SessionBlocEvent { const ToggleAudioEvent(); }
class AcceptIncomingSessionEvent extends SessionBlocEvent {
  final String fromUid;
  final Map<String, dynamic> sdp;
  const AcceptIncomingSessionEvent({required this.fromUid, required this.sdp});
  @override List<Object?> get props => [fromUid];
}
class RemoteSdpReceivedEvent extends SessionBlocEvent {
  final Map<String, dynamic> sdp;
  final String type;
  const RemoteSdpReceivedEvent({required this.sdp, required this.type});
}
class RemoteCandidateReceivedEvent extends SessionBlocEvent {
  final Map<String, dynamic> candidate;
  const RemoteCandidateReceivedEvent(this.candidate);
}
class UpdateStatsEvent extends SessionBlocEvent {
  final WebRtcStats stats;
  const UpdateStatsEvent(this.stats);
  @override List<Object?> get props => [stats];
}
