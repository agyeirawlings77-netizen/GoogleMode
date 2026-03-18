import 'package:equatable/equatable.dart';

abstract class DeviceManagementEvent extends Equatable {
  const DeviceManagementEvent();
  @override List<Object?> get props => [];
}
class LoadDevicesEvent extends DeviceManagementEvent { const LoadDevicesEvent(); }
class RegisterThisDeviceEvent extends DeviceManagementEvent { const RegisterThisDeviceEvent(); }
class GenerateQrCodeEvent extends DeviceManagementEvent { const GenerateQrCodeEvent(); }
class ScanQrCodeEvent extends DeviceManagementEvent {
  final String qrData;
  const ScanQrCodeEvent(this.qrData);
  @override List<Object?> get props => [qrData];
}
class RemoveDeviceEvent extends DeviceManagementEvent {
  final String deviceId;
  const RemoveDeviceEvent(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class RenameDeviceEvent extends DeviceManagementEvent {
  final String deviceId, newName;
  const RenameDeviceEvent(this.deviceId, this.newName);
  @override List<Object?> get props => [deviceId, newName];
}
