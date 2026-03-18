import 'package:equatable/equatable.dart';
import '../model/trusted_device_model.dart';

abstract class TrustedDeviceEvent extends Equatable {
  const TrustedDeviceEvent();
  @override List<Object?> get props => [];
}
class LoadTrustedDevicesEvent extends TrustedDeviceEvent { const LoadTrustedDevicesEvent(); }
class SaveTrustedDeviceEvent extends TrustedDeviceEvent {
  final TrustedDeviceModel device;
  const SaveTrustedDeviceEvent(this.device);
  @override List<Object?> get props => [device];
}
class RemoveTrustedDeviceEvent extends TrustedDeviceEvent {
  final String deviceId;
  const RemoveTrustedDeviceEvent(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class ToggleAutoConnectEvent extends TrustedDeviceEvent {
  final String deviceId;
  final bool autoConnect;
  const ToggleAutoConnectEvent(this.deviceId, this.autoConnect);
  @override List<Object?> get props => [deviceId, autoConnect];
}
class WatchPresenceEvent extends TrustedDeviceEvent {
  final String deviceId;
  final String ownerUserId;
  const WatchPresenceEvent(this.deviceId, this.ownerUserId);
  @override List<Object?> get props => [deviceId, ownerUserId];
}
class PresenceUpdatedEvent extends TrustedDeviceEvent {
  final String deviceId;
  final bool online;
  const PresenceUpdatedEvent(this.deviceId, this.online);
  @override List<Object?> get props => [deviceId, online];
}
