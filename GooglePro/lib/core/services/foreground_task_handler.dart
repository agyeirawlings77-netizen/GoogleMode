import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';
import 'trusted_device_manager.dart';

class ForegroundTaskHandler extends TaskHandler {
  StreamSubscription? _authSub;
  StreamSubscription? _signalSub;
  String? _uid;
  TrustedDeviceManager? _manager;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    AppLogger.info('ForegroundTask: Started');
    _manager = TrustedDeviceManager(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ));
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null && _uid != user.uid) {
        _uid = user.uid;
        _watchSignals(user.uid);
      } else if (user == null) {
        _uid = null;
        await _signalSub?.cancel();
        _signalSub = null;
      }
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) { _uid = user.uid; _watchSignals(user.uid); }
  }

  void _watchSignals(String uid) {
    _signalSub?.cancel();
    _signalSub = FirebaseDatabase.instance
        .ref('${AppConstants.autoConnectSignalsPath}/$uid')
        .onChildAdded
        .listen((event) async {
      final deviceId = event.snapshot.key;
      if (deviceId == null) return;
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data?['pending'] == true) {
        await FirebaseDatabase.instance
            .ref('${AppConstants.autoConnectSignalsPath}/$uid/$deviceId')
            .remove();
        final trusted = await _manager?.isTrusted(deviceId) ?? false;
        if (trusted) {
          FlutterForegroundTask.sendDataToMain({'action': 'auto_connect', 'deviceId': deviceId});
          AppLogger.info('ForegroundTask: Auto-connect signal → $deviceId');
        }
      }
    });
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) _updatePresence(user.uid);
  }

  Future<void> _updatePresence(String uid) async {
    try {
      final ref = FirebaseDatabase.instance.ref('${AppConstants.presencePath}/$uid/self');
      await ref.update({'online': true, 'lastSeen': ServerValue.timestamp});
      await ref.onDisconnect().update({'online': false, 'lastSeen': ServerValue.timestamp});
    } catch (e) { AppLogger.warning('Presence update failed: $e'); }
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    AppLogger.info('ForegroundTask: Destroying');
    await _authSub?.cancel();
    await _signalSub?.cancel();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseDatabase.instance.ref('${AppConstants.presencePath}/${user.uid}/self')
            .update({'online': false, 'lastSeen': ServerValue.timestamp});
      } catch (_) {}
    }
  }

  @override
  void onReceiveData(Object data) => AppLogger.debug('ForegroundTask data: $data');
}

class ForegroundServiceHelper {
  static Future<void> start() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: AppConstants.channelForegroundService,
        channelName: 'GooglePro Service',
        channelDescription: 'Keeps GooglePro running for auto-connect',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: true, playSound: false),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'GooglePro Active',
        notificationText: 'Monitoring connected devices',
        callback: _startCallback,
      );
    }
  }

  static Future<void> stop() async => FlutterForegroundTask.stopService();

  static Future<void> updateNotification(String title, String text) async =>
      FlutterForegroundTask.updateService(notificationTitle: title, notificationText: text);
}

@pragma('vm:entry-point')
void _startCallback() {
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}
