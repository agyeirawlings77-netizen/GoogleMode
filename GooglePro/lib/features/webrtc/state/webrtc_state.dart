import 'package:equatable/equatable.dart';
import '../model/peer_connection_state.dart';
import '../model/connection_stats.dart';

abstract class WebRtcState extends Equatable {
  const WebRtcState();
  @override List<Object?> get props => [];
}
class WebRtcIdle extends WebRtcState { const WebRtcIdle(); }
class WebRtcConnecting extends WebRtcState {
  final String targetDeviceId;
  const WebRtcConnecting(this.targetDeviceId);
  @override List<Object?> get props => [targetDeviceId];
}
class WebRtcConnected extends WebRtcState {
  final String sessionId;
  final String remoteDeviceId;
  final bool isScreenSharing;
  const WebRtcConnected({required this.sessionId, required this.remoteDeviceId, this.isScreenSharing = false});
  @override List<Object?> get props => [sessionId, remoteDeviceId, isScreenSharing];
}
class WebRtcError extends WebRtcState {
  final String message;
  const WebRtcError(this.message);
  @override List<Object?> get props => [message];
}
class WebRtcDisconnected extends WebRtcState { const WebRtcDisconnected(); }
class WebRtcIncomingCall extends WebRtcState {
  final String fromDeviceId;
  final Map<String, dynamic> offerData;
  const WebRtcIncomingCall({required this.fromDeviceId, required this.offerData});
  @override List<Object?> get props => [fromDeviceId];
}
