import 'dart:isolate';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../../core/utils/app_logger.dart';

// Entry point for flutter_foreground_task's isolate
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(GoogleProForegroundHandler());
}

class GoogleProForegroundHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    AppLogger.info('Foreground task started');
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // Called every 5 seconds per flutter_foreground_task config
    // Check if any trusted device came online; signal main isolate to connect
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    AppLogger.debug('Foreground task: heartbeat tick');
    sendPort?.send({'action': 'check_trusted_devices', 'uid': uid});
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    AppLogger.info('Foreground task destroyed');
  }

  @override
  void onNotificationButtonPressed(String id) {
    AppLogger.info('Foreground task notification button: $id');
  }

  @override
  void onNotificationDismissed() {
    AppLogger.info('Foreground task notification dismissed');
  }
}
