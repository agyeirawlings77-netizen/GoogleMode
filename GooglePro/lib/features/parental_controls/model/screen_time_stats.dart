class AppUsageStat {
  final String packageName;
  final String appName;
  final int usedMinutes;
  final int limitMinutes;
  const AppUsageStat({required this.packageName, required this.appName, required this.usedMinutes, this.limitMinutes = 0});
  double get usagePercent => limitMinutes > 0 ? (usedMinutes / limitMinutes).clamp(0.0, 1.0) : 0.0;
  bool get isOverLimit => limitMinutes > 0 && usedMinutes >= limitMinutes;
}
class ScreenTimeStats {
  final int totalUsedMinutes;
  final int dailyLimitMinutes;
  final List<AppUsageStat> appStats;
  final DateTime date;
  const ScreenTimeStats({required this.totalUsedMinutes, required this.dailyLimitMinutes, required this.appStats, required this.date});
  double get overallPercent => dailyLimitMinutes > 0 ? (totalUsedMinutes / dailyLimitMinutes).clamp(0.0, 1.0) : 0.0;
  bool get isOverLimit => dailyLimitMinutes > 0 && totalUsedMinutes >= dailyLimitMinutes;
  String get timeUsedFormatted { final h = totalUsedMinutes ~/ 60; final m = totalUsedMinutes % 60; return h > 0 ? '${h}h ${m}m' : '${m}m'; }
}
