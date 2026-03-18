import 'package:equatable/equatable.dart';
import '../model/session_model.dart';

abstract class SessionState extends Equatable {
  const SessionState();
  @override List<Object?> get props => [];
}
class SessionIdle extends SessionState { const SessionIdle(); }
class SessionConnecting extends SessionState {
  final String deviceId;
  const SessionConnecting(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class SessionActive extends SessionState {
  final SessionModel session;
  const SessionActive(this.session);
  @override List<Object?> get props => [session];
}
class SessionEnded extends SessionState { const SessionEnded(); }
class SessionError extends SessionState {
  final String message;
  const SessionError(this.message);
  @override List<Object?> get props => [message];
}
class SessionIncomingRequest extends SessionState {
  final String fromDeviceId;
  final String fromDeviceName;
  final Map<String, dynamic> offerData;
  const SessionIncomingRequest({required this.fromDeviceId, required this.fromDeviceName, required this.offerData});
  @override List<Object?> get props => [fromDeviceId];
}
