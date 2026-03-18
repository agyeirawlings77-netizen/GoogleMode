enum DeviceTypeLocal { phone, tablet, laptop, desktop, unknown }

class DeviceModelLocal {
  final String deviceId;
  final String deviceName;
  final DeviceTypeLocal type;
  final String ownerUserId;
  final bool isOnline;
  final String? fcmToken;
  final String? osVersion;
  final String? appVersion;
  final int? batteryLevel;
  final DateTime? lastSeen;
  final bool isTrusted;

  const DeviceModelLocal({required this.deviceId, required this.deviceName, this.type = DeviceTypeLocal.phone, required this.ownerUserId, this.isOnline = false, this.fcmToken, this.osVersion, this.appVersion, this.batteryLevel, this.lastSeen, this.isTrusted = false});

  DeviceModelLocal copyWith({String? deviceName, bool? isOnline, String? fcmToken, int? batteryLevel, bool? isTrusted}) =>
    DeviceModelLocal(deviceId: deviceId, deviceName: deviceName ?? this.deviceName, type: type, ownerUserId: ownerUserId, isOnline: isOnline ?? this.isOnline, fcmToken: fcmToken ?? this.fcmToken, osVersion: osVersion, appVersion: appVersion, batteryLevel: batteryLevel ?? this.batteryLevel, lastSeen: lastSeen, isTrusted: isTrusted ?? this.isTrusted);

  factory DeviceModelLocal.fromJson(Map<String, dynamic> j) => DeviceModelLocal(deviceId: j['deviceId'] ?? '', deviceName: j['deviceName'] ?? 'Device', type: DeviceTypeLocal.values.firstWhere((t) => t.name == j['type'], orElse: () => DeviceTypeLocal.phone), ownerUserId: j['ownerUserId'] ?? '', isOnline: j['isOnline'] ?? false, fcmToken: j['fcmToken'], osVersion: j['osVersion'], appVersion: j['appVersion'], batteryLevel: j['batteryLevel'] as int?, isTrusted: j['isTrusted'] ?? false);

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'type': type.name, 'ownerUserId': ownerUserId, 'isOnline': isOnline, 'fcmToken': fcmToken, 'osVersion': osVersion, 'appVersion': appVersion, 'batteryLevel': batteryLevel, 'isTrusted': isTrusted};

  String get typeLabel { switch (type) { case DeviceTypeLocal.tablet: return 'Tablet'; case DeviceTypeLocal.laptop: return 'Laptop'; case DeviceTypeLocal.desktop: return 'Desktop'; default: return 'Phone'; } }
}
