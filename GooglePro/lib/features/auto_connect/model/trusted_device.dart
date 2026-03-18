class TrustedDevice {
  final String deviceId;
  final String deviceName;
  final String ownerUid;
  final DateTime pairedAt;
  final String? fcmToken;
  final bool autoConnect;

  const TrustedDevice({required this.deviceId, required this.deviceName, required this.ownerUid, required this.pairedAt, this.fcmToken, this.autoConnect = true});

  TrustedDevice copyWith({String? deviceName, String? fcmToken, bool? autoConnect}) =>
    TrustedDevice(deviceId: deviceId, deviceName: deviceName ?? this.deviceName, ownerUid: ownerUid, pairedAt: pairedAt, fcmToken: fcmToken ?? this.fcmToken, autoConnect: autoConnect ?? this.autoConnect);

  factory TrustedDevice.fromJson(Map<String, dynamic> j) => TrustedDevice(deviceId: j['deviceId'] ?? '', deviceName: j['deviceName'] ?? '', ownerUid: j['ownerUid'] ?? '', pairedAt: j['pairedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(j['pairedAt'] as int) : DateTime.now(), fcmToken: j['fcmToken'], autoConnect: j['autoConnect'] ?? true);

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'ownerUid': ownerUid, 'pairedAt': pairedAt.millisecondsSinceEpoch, 'fcmToken': fcmToken, 'autoConnect': autoConnect};
}
