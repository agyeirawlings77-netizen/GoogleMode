class TrustedDeviceModel {
  final String deviceId;
  final String deviceName;
  final String deviceType;
  final String ownerUserId;
  final String? fcmToken;
  final String? avatarUrl;
  final DateTime savedAt;
  final DateTime lastConnectedAt;
  final bool autoConnect;
  const TrustedDeviceModel({required this.deviceId, required this.deviceName, required this.deviceType, required this.ownerUserId, this.fcmToken, this.avatarUrl, required this.savedAt, required this.lastConnectedAt, this.autoConnect = true});
  TrustedDeviceModel copyWith({String? deviceId, String? deviceName, String? deviceType, String? ownerUserId, String? fcmToken, String? avatarUrl, DateTime? savedAt, DateTime? lastConnectedAt, bool? autoConnect}) =>
    TrustedDeviceModel(deviceId: deviceId ?? this.deviceId, deviceName: deviceName ?? this.deviceName, deviceType: deviceType ?? this.deviceType, ownerUserId: ownerUserId ?? this.ownerUserId, fcmToken: fcmToken ?? this.fcmToken, avatarUrl: avatarUrl ?? this.avatarUrl, savedAt: savedAt ?? this.savedAt, lastConnectedAt: lastConnectedAt ?? this.lastConnectedAt, autoConnect: autoConnect ?? this.autoConnect);
  factory TrustedDeviceModel.fromJson(Map<String, dynamic> j) => TrustedDeviceModel(deviceId: j['deviceId'], deviceName: j['deviceName'], deviceType: j['deviceType'], ownerUserId: j['ownerUserId'], fcmToken: j['fcmToken'], avatarUrl: j['avatarUrl'], savedAt: DateTime.parse(j['savedAt']), lastConnectedAt: DateTime.parse(j['lastConnectedAt']), autoConnect: j['autoConnect'] ?? true);
  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'deviceType': deviceType, 'ownerUserId': ownerUserId, 'fcmToken': fcmToken, 'avatarUrl': avatarUrl, 'savedAt': savedAt.toIso8601String(), 'lastConnectedAt': lastConnectedAt.toIso8601String(), 'autoConnect': autoConnect};
}
