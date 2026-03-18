import '../../domain/entities/device_entity.dart';

class DeviceModel extends DeviceEntity {
  const DeviceModel({required super.deviceId, required super.deviceName, super.type, required super.ownerUserId, super.status, super.fcmToken, super.osVersion, super.appVersion, super.batteryLevel});

  factory DeviceModel.fromJson(Map<String, dynamic> j) => DeviceModel(deviceId: j['deviceId'] ?? '', deviceName: j['deviceName'] ?? 'Device', type: DeviceType.values.firstWhere((t) => t.name == j['type'], orElse: () => DeviceType.phone), ownerUserId: j['ownerUserId'] ?? '', status: j['isOnline'] == true ? DeviceStatus.online : DeviceStatus.offline, fcmToken: j['fcmToken'], osVersion: j['osVersion'], appVersion: j['appVersion'], batteryLevel: j['batteryLevel'] as int?);

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'type': type.name, 'ownerUserId': ownerUserId, 'isOnline': isOnline, 'fcmToken': fcmToken, 'osVersion': osVersion, 'appVersion': appVersion, 'batteryLevel': batteryLevel};

  DeviceModel copyWith({String? deviceName, DeviceStatus? status, String? fcmToken, int? batteryLevel}) =>
    DeviceModel(deviceId: deviceId, deviceName: deviceName ?? this.deviceName, type: type, ownerUserId: ownerUserId, status: status ?? this.status, fcmToken: fcmToken ?? this.fcmToken, osVersion: osVersion, appVersion: appVersion, batteryLevel: batteryLevel ?? this.batteryLevel);
}
