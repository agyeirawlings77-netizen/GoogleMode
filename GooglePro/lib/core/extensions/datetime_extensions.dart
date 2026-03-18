extension DateTimeExtensions on DateTime {
  bool get isToday { final now = DateTime.now(); return year == now.year && month == now.month && day == now.day; }
  bool get isYesterday { final y = DateTime.now().subtract(const Duration(days: 1)); return year == y.year && month == y.month && day == y.day; }
  bool get isTomorrow { final t = DateTime.now().add(const Duration(days: 1)); return year == t.year && month == t.month && day == t.day; }
  bool get isInPast => isBefore(DateTime.now());
  bool get isInFuture => isAfter(DateTime.now());
  String get timeAgo { final d = DateTime.now().difference(this); if (d.inSeconds < 60) return 'Just now'; if (d.inMinutes < 60) return '${d.inMinutes}m ago'; if (d.inHours < 24) return '${d.inHours}h ago'; if (d.inDays < 7) return '${d.inDays}d ago'; return '${d.inDays ~/ 7}w ago'; }
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
  int get timestamp => millisecondsSinceEpoch;
}
