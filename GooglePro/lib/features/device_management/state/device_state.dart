import 'package:equatable/equatable.dart';
import '../model/device_model_local.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();
  @override List<Object?> get props => [];
}
class DeviceInitial extends DeviceState { const DeviceInitial(); }
class DeviceLoading extends DeviceState { const DeviceLoading(); }
class DeviceLoaded extends DeviceState {
  final List<DeviceModelLocal> devices;
  const DeviceLoaded(this.devices);
  @override List<Object?> get props => [devices];
  int get onlineCount => devices.where((d) => d.isOnline).length;
}
class DeviceError extends DeviceState {
  final String message;
  const DeviceError(this.message);
  @override List<Object?> get props => [message];
}
class DeviceRegistered extends DeviceState {
  final DeviceModelLocal device;
  const DeviceRegistered(this.device);
  @override List<Object?> get props => [device.deviceId];
}
class DeviceDeleted extends DeviceState { const DeviceDeleted(); }
