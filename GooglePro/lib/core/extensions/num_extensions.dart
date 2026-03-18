extension NumExtensions on num {
  String get formatBitrate { if (this < 1000) return '${toStringAsFixed(0)} kbps'; return '${(this / 1000).toStringAsFixed(1)} Mbps'; }
  String get formatBytes { if (this < 1024) return '$this B'; if (this < 1048576) return '${(this / 1024).toStringAsFixed(1)} KB'; if (this < 1073741824) return '${(this / 1048576).toStringAsFixed(1)} MB'; return '${(this / 1073741824).toStringAsFixed(2)} GB'; }
  double get clamp01 => clamp(0.0, 1.0).toDouble();
  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  Duration get seconds => Duration(seconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
}
