import 'dart:convert';

class PairingData {
  final String deviceId;
  final String deviceName;
  final String ownerUid;
  final String? fcmToken;
  final int timestamp;

  const PairingData({required this.deviceId, required this.deviceName, required this.ownerUid, this.fcmToken, required this.timestamp});

  factory PairingData.fromJson(Map<String, dynamic> j) => PairingData(deviceId: j['deviceId'] ?? '', deviceName: j['deviceName'] ?? '', ownerUid: j['ownerUid'] ?? '', fcmToken: j['fcmToken'], timestamp: j['ts'] as int? ?? 0);

  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'deviceName': deviceName, 'ownerUid': ownerUid, 'fcmToken': fcmToken, 'ts': timestamp};

  String toQrString() => jsonEncode(toJson());

  static PairingData? fromQrString(String raw) {
    try { return PairingData.fromJson(jsonDecode(raw) as Map<String, dynamic>); }
    catch (_) { return null; }
  }

  bool get isExpired => DateTime.now().millisecondsSinceEpoch - timestamp > 300000; // 5 min
}
