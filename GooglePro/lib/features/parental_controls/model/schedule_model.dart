class TimeWindow {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  const TimeWindow({required this.startHour, required this.startMinute, required this.endHour, required this.endMinute});
  bool get isActive { final now = DateTime.now(); final start = now.copyWith(hour: startHour, minute: startMinute, second: 0); final end = now.copyWith(hour: endHour, minute: endMinute, second: 0); return now.isAfter(start) && now.isBefore(end); }
  Map<String, dynamic> toJson() => {'startHour': startHour, 'startMinute': startMinute, 'endHour': endHour, 'endMinute': endMinute};
  factory TimeWindow.fromJson(Map<String, dynamic> j) => TimeWindow(startHour: j['startHour'] ?? 0, startMinute: j['startMinute'] ?? 0, endHour: j['endHour'] ?? 23, endMinute: j['endMinute'] ?? 59);
}
class ScheduleModel {
  final String scheduleId;
  final String name;
  final List<int> activeDays;
  final TimeWindow window;
  final bool blockDevice;
  final bool blockApps;
  final bool enabled;
  const ScheduleModel({required this.scheduleId, required this.name, required this.activeDays, required this.window, this.blockDevice = false, this.blockApps = true, this.enabled = true});
  factory ScheduleModel.fromJson(Map<String, dynamic> j) => ScheduleModel(scheduleId: j['scheduleId'] ?? '', name: j['name'] ?? '', activeDays: List<int>.from(j['activeDays'] ?? []), window: TimeWindow.fromJson(j['window'] ?? {}), blockDevice: j['blockDevice'] ?? false, blockApps: j['blockApps'] ?? true, enabled: j['enabled'] ?? true);
  Map<String, dynamic> toJson() => {'scheduleId': scheduleId, 'name': name, 'activeDays': activeDays, 'window': window.toJson(), 'blockDevice': blockDevice, 'blockApps': blockApps, 'enabled': enabled};
}
