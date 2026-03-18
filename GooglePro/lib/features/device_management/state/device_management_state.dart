import 'package:equatable/equatable.dart';
import '../model/device_model.dart';

abstract class DeviceManagementState extends Equatable {
  const DeviceManagementState();
  @override List<Object?> get props => [];
}
class DeviceManagementInitial extends DeviceManagementState { const DeviceManagementInitial(); }
class DeviceManagementLoading extends DeviceManagementState { const DeviceManagementLoading(); }
class DevicesLoaded extends DeviceManagementState {
  final List<DeviceModel> devices;
  final DeviceModel? thisDevice;
  const DevicesLoaded({required this.devices, this.thisDevice});
  @override List<Object?> get props => [devices, thisDevice];
}
class DeviceManagementError extends DeviceManagementState {
  final String message;
  const DeviceManagementError(this.message);
  @override List<Object?> get props => [message];
}
class QrCodeGenerated extends DeviceManagementState {
  final String qrData;
  const QrCodeGenerated(this.qrData);
  @override List<Object?> get props => [qrData];
}
class DevicePaired extends DeviceManagementState {
  final DeviceModel device;
  const DevicePaired(this.device);
  @override List<Object?> get props => [device];
}
class DeviceRegistered extends DeviceManagementState { const DeviceRegistered(); }
