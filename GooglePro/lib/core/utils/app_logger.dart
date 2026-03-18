import 'package:flutter/foundation.dart';
class AppLogger {
  static void info(String message) { if (kDebugMode) debugPrint('[INFO] $message'); }
  static void debug(String message) { if (kDebugMode) debugPrint('[DEBUG] $message'); }
  static void warning(String message) { if (kDebugMode) debugPrint('[WARN] $message'); }
  static void error(String message, [dynamic error, StackTrace? stack]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('  Error: $error');
      if (stack != null) debugPrint('  Stack: $stack');
    }
  }
}
