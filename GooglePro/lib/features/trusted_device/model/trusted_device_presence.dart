class TrustedDevicePresence {
  final String deviceId;
  final bool online;
  final DateTime? lastSeen;
  final String? ipAddress;
  final int? batteryLevel;
  const TrustedDevicePresence({required this.deviceId, required this.online, this.lastSeen, this.ipAddress, this.batteryLevel});
  factory TrustedDevicePresence.fromMap(String id, Map<dynamic, dynamic> m) => TrustedDevicePresence(deviceId: id, online: m['online'] ?? false, lastSeen: m['lastSeen'] != null ? DateTime.fromMillisecondsSinceEpoch(m['lastSeen'] as int) : null, ipAddress: m['ipAddress'], batteryLevel: m['batteryLevel'] as int?);
}
