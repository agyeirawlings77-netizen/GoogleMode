import 'package:equatable/equatable.dart';
abstract class RemoteControlState extends Equatable {
  const RemoteControlState();
  @override List<Object?> get props => [];
}
class RemoteControlIdle extends RemoteControlState { const RemoteControlIdle(); }
class RemoteControlActive extends RemoteControlState {
  final String deviceId;
  final bool isEnabled;
  const RemoteControlActive({required this.deviceId, this.isEnabled = true});
  @override List<Object?> get props => [deviceId, isEnabled];
  RemoteControlActive copyWith({bool? isEnabled}) => RemoteControlActive(deviceId: deviceId, isEnabled: isEnabled ?? this.isEnabled);
}
class RemoteControlError extends RemoteControlState {
  final String message;
  const RemoteControlError(this.message);
  @override List<Object?> get props => [message];
}
