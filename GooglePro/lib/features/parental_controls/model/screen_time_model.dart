class ScreenTimeModel {
  final String deviceId;
  final DateTime date;
  final int totalMinutes;
  final Map<String, int> appUsageMinutes; // packageName → minutes
  final int screenOnCount;
  final int unlockCount;

  const ScreenTimeModel({required this.deviceId, required this.date, required this.totalMinutes, required this.appUsageMinutes, this.screenOnCount = 0, this.unlockCount = 0});

  factory ScreenTimeModel.fromJson(Map<String, dynamic> j) => ScreenTimeModel(deviceId: j['deviceId'] ?? '', date: DateTime.parse(j['date'] ?? DateTime.now().toIso8601String()), totalMinutes: j['totalMinutes'] ?? 0, appUsageMinutes: Map<String, int>.from(j['appUsageMinutes'] ?? {}), screenOnCount: j['screenOnCount'] ?? 0, unlockCount: j['unlockCount'] ?? 0);
  Map<String, dynamic> toJson() => {'deviceId': deviceId, 'date': date.toIso8601String(), 'totalMinutes': totalMinutes, 'appUsageMinutes': appUsageMinutes, 'screenOnCount': screenOnCount, 'unlockCount': unlockCount};

  String get formattedTotal { final h = totalMinutes ~/ 60; final m = totalMinutes % 60; return h > 0 ? '${h}h ${m}m' : '${m}m'; }
}
