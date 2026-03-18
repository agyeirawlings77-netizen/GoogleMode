import 'package:equatable/equatable.dart';
abstract class DeviceEvent extends Equatable {
  const DeviceEvent();
  @override List<Object?> get props => [];
}
class LoadDevicesEvent extends DeviceEvent { const LoadDevicesEvent(); }
class RegisterDeviceEvent extends DeviceEvent { const RegisterDeviceEvent(); }
class DeleteDeviceEvent extends DeviceEvent {
  final String deviceId;
  const DeleteDeviceEvent(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class RenameDeviceEvent extends DeviceEvent {
  final String deviceId;
  final String name;
  const RenameDeviceEvent(this.deviceId, this.name);
  @override List<Object?> get props => [deviceId, name];
}
class ToggleTrustDeviceEvent extends DeviceEvent {
  final String deviceId;
  final bool trusted;
  const ToggleTrustDeviceEvent(this.deviceId, this.trusted);
  @override List<Object?> get props => [deviceId, trusted];
}
