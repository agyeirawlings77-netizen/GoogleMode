extension IntExtensions on int {
  String get fileSizeFormatted {
    if (this < 1024) return '$this B';
    if (this < 1048576) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1073741824) return '${(this / 1048576).toStringAsFixed(1)} MB';
    return '${(this / 1073741824).toStringAsFixed(1)} GB';
  }
  String get durationFormatted {
    final h = this ~/ 3600;
    final m = (this % 3600) ~/ 60;
    final s = this % 60;
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  bool get isEven => this % 2 == 0;
  int clampBetween(int min, int max) => clamp(min, max);
}
