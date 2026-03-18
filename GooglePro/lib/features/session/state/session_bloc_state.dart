import 'package:equatable/equatable.dart';
import '../../webrtc/model/webrtc_state.dart';

abstract class SessionBlocState extends Equatable {
  const SessionBlocState();
  @override List<Object?> get props => [];
}
class SessionIdle extends SessionBlocState { const SessionIdle(); }
class SessionConnecting extends SessionBlocState {
  final String deviceName;
  final String deviceId;
  const SessionConnecting({required this.deviceName, required this.deviceId});
  @override List<Object?> get props => [deviceId];
}
class SessionActive extends SessionBlocState {
  final String sessionId;
  final String deviceId;
  final String deviceName;
  final WebRtcConnectionState webRtcState;
  final WebRtcStats stats;
  final bool isHost;
  final bool videoEnabled;
  final bool audioEnabled;
  const SessionActive({required this.sessionId, required this.deviceId, required this.deviceName, this.webRtcState = WebRtcConnectionState.connected, this.stats = const WebRtcStats(), this.isHost = false, this.videoEnabled = true, this.audioEnabled = true});
  @override List<Object?> get props => [sessionId, webRtcState, videoEnabled, audioEnabled];
  SessionActive copyWith({WebRtcConnectionState? webRtcState, WebRtcStats? stats, bool? videoEnabled, bool? audioEnabled}) =>
    SessionActive(sessionId: sessionId, deviceId: deviceId, deviceName: deviceName, webRtcState: webRtcState ?? this.webRtcState, stats: stats ?? this.stats, isHost: isHost, videoEnabled: videoEnabled ?? this.videoEnabled, audioEnabled: audioEnabled ?? this.audioEnabled);
}
class SessionReconnecting extends SessionBlocState {
  final int attempt;
  const SessionReconnecting(this.attempt);
  @override List<Object?> get props => [attempt];
}
class SessionEnded extends SessionBlocState {
  final String reason;
  const SessionEnded({this.reason = 'Session ended'});
  @override List<Object?> get props => [reason];
}
class SessionError extends SessionBlocState {
  final String message;
  const SessionError(this.message);
  @override List<Object?> get props => [message];
}
