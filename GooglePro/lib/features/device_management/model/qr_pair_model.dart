import 'dart:convert';

class QrPairModel {
  final String deviceId;
  final String ownerUserId;
  final String deviceName;
  final String deviceType;
  final String? fcmToken;
  final int timestamp;

  const QrPairModel({required this.deviceId, required this.ownerUserId, required this.deviceName, required this.deviceType, this.fcmToken, required this.timestamp});

  factory QrPairModel.fromJson(Map<String, dynamic> j) => QrPairModel(deviceId: j['deviceId'], ownerUserId: j['ownerUserId'], deviceName: j['deviceName'], deviceType: j['deviceType'], fcmToken: j['fcmToken'], timestamp: j['timestamp'] ?? 0);
  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'ownerUserId': ownerUserId, 'deviceName': deviceName, 'deviceType': deviceType, 'fcmToken': fcmToken, 'timestamp': timestamp};

  String toQrString() => jsonEncode(toJson());
  static QrPairModel? fromQrString(String raw) {
    try { return QrPairModel.fromJson(jsonDecode(raw) as Map<String, dynamic>); }
    catch (_) { return null; }
  }

  bool get isExpired => DateTime.now().millisecondsSinceEpoch - timestamp > 300000; // 5 min
}
