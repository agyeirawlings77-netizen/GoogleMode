class DeviceModel {
  final String deviceId;
  final String deviceName;
  final String deviceType;
  final String ownerUserId;
  final String? fcmToken;
  final String? avatarUrl;
  final bool isOnline;
  final int? batteryLevel;
  final String? osVersion;
  final String? appVersion;
  final String? ipAddress;
  final DateTime? lastSeen;
  final Map<String, dynamic>? extras;

  const DeviceModel({required this.deviceId, required this.deviceName, required this.deviceType, required this.ownerUserId, this.fcmToken, this.avatarUrl, this.isOnline = false, this.batteryLevel, this.osVersion, this.appVersion, this.ipAddress, this.lastSeen, this.extras});

  DeviceModel copyWith({String? deviceId, String? deviceName, String? deviceType, String? ownerUserId, String? fcmToken, String? avatarUrl, bool? isOnline, int? batteryLevel, String? osVersion, String? appVersion, String? ipAddress, DateTime? lastSeen, Map<String, dynamic>? extras}) =>
    DeviceModel(deviceId: deviceId ?? this.deviceId, deviceName: deviceName ?? this.deviceName, deviceType: deviceType ?? this.deviceType, ownerUserId: ownerUserId ?? this.ownerUserId, fcmToken: fcmToken ?? this.fcmToken, avatarUrl: avatarUrl ?? this.avatarUrl, isOnline: isOnline ?? this.isOnline, batteryLevel: batteryLevel ?? this.batteryLevel, osVersion: osVersion ?? this.osVersion, appVersion: appVersion ?? this.appVersion, ipAddress: ipAddress ?? this.ipAddress, lastSeen: lastSeen ?? this.lastSeen, extras: extras ?? this.extras);

  factory DeviceModel.fromJson(Map<String, dynamic> j) => DeviceModel(deviceId: j['deviceId'] ?? '', deviceName: j['deviceName'] ?? 'Unknown', deviceType: j['deviceType'] ?? 'phone', ownerUserId: j['ownerUserId'] ?? '', fcmToken: j['fcmToken'], avatarUrl: j['avatarUrl'], isOnline: j['isOnline'] ?? false, batteryLevel: j['batteryLevel'] as int?, osVersion: j['osVersion'], appVersion: j['appVersion'], ipAddress: j['ipAddress'], lastSeen: j['lastSeen'] != null ? DateTime.tryParse(j['lastSeen']) : null);

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'deviceType': deviceType, 'ownerUserId': ownerUserId, 'fcmToken': fcmToken, 'avatarUrl': avatarUrl, 'isOnline': isOnline, 'batteryLevel': batteryLevel, 'osVersion': osVersion, 'appVersion': appVersion, 'ipAddress': ipAddress, 'lastSeen': lastSeen?.toIso8601String()};
}
