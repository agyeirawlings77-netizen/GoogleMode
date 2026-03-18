enum AppCategory { social, games, entertainment, productivity, education, other }
enum RuleType { block, timeLimit, scheduleAllow }

class AppUsageRule {
  final String ruleId;
  final String packageName;
  final String appName;
  final AppCategory category;
  final RuleType type;
  final int? dailyLimitMinutes;
  final List<TimeWindow>? allowedWindows;
  final bool isBlocked;
  final DateTime createdAt;

  const AppUsageRule({required this.ruleId, required this.packageName, required this.appName, required this.category, required this.type, this.dailyLimitMinutes, this.allowedWindows, this.isBlocked = false, required this.createdAt});

  AppUsageRule copyWith({bool? isBlocked, int? dailyLimitMinutes}) => AppUsageRule(ruleId: ruleId, packageName: packageName, appName: appName, category: category, type: type, dailyLimitMinutes: dailyLimitMinutes ?? this.dailyLimitMinutes, allowedWindows: allowedWindows, isBlocked: isBlocked ?? this.isBlocked, createdAt: createdAt);

  factory AppUsageRule.fromJson(Map<String, dynamic> j) => AppUsageRule(ruleId: j['ruleId'] ?? '', packageName: j['packageName'] ?? '', appName: j['appName'] ?? '', category: AppCategory.values.firstWhere((c) => c.name == j['category'], orElse: () => AppCategory.other), type: RuleType.values.firstWhere((t) => t.name == j['type'], orElse: () => RuleType.block), dailyLimitMinutes: j['dailyLimitMinutes'] as int?, isBlocked: j['isBlocked'] ?? false, createdAt: DateTime.parse(j['createdAt'] ?? DateTime.now().toIso8601String()));

  Map<String, dynamic> toJson() => {'ruleId': ruleId, 'packageName': packageName, 'appName': appName, 'category': category.name, 'type': type.name, 'dailyLimitMinutes': dailyLimitMinutes, 'isBlocked': isBlocked, 'createdAt': createdAt.toIso8601String()};
}

class TimeWindow {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final List<int> daysOfWeek; // 1=Mon...7=Sun
  const TimeWindow({required this.startHour, required this.startMinute, required this.endHour, required this.endMinute, required this.daysOfWeek});
  factory TimeWindow.fromJson(Map<String, dynamic> j) => TimeWindow(startHour: j['startHour'] ?? 0, startMinute: j['startMinute'] ?? 0, endHour: j['endHour'] ?? 23, endMinute: j['endMinute'] ?? 59, daysOfWeek: List<int>.from(j['daysOfWeek'] ?? [1,2,3,4,5,6,7]));
  Map<String, dynamic> toJson() => {'startHour': startHour, 'startMinute': startMinute, 'endHour': endHour, 'endMinute': endMinute, 'daysOfWeek': daysOfWeek};
}
