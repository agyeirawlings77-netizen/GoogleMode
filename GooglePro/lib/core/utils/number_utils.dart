class NumberUtils {
  static String formatBitrate(int kbps) { if (kbps >= 1000) return '${(kbps / 1000).toStringAsFixed(1)} Mbps'; return '$kbps kbps'; }
  static String formatLatency(int ms) { if (ms < 1000) return '${ms}ms'; return '${(ms / 1000).toStringAsFixed(1)}s'; }
  static String formatPercentage(double value) => '${(value * 100).toStringAsFixed(1)}%';
  static double clamp(double val, double min, double max) => val.clamp(min, max);
  static int safeParseInt(dynamic val, {int defaultValue = 0}) { if (val == null) return defaultValue; if (val is int) return val; if (val is double) return val.round(); return int.tryParse(val.toString()) ?? defaultValue; }
}
