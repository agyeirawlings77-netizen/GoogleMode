import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

@singleton
class KeepAliveService {
  Future<void> startForegroundService() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: AppConstants.channelForegroundService,
        channelName: 'GooglePro Service',
        channelDescription: 'Keeps GooglePro running for auto-connect',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(resType: ResourceType.mipmap, resPrefix: ResourcePrefix.ic, name: 'launcher'),
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: const ForegroundTaskOptions(interval: 5000, autoRunOnBoot: true, allowWakeLock: true, allowWifiLock: true),
    );
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(serviceId: 256, notificationTitle: 'GooglePro Active', notificationText: 'Monitoring devices', callback: _taskCallback);
    }
    AppLogger.info('Foreground service started');
  }

  Future<void> stopForegroundService() async {
    await FlutterForegroundTask.stopService();
    AppLogger.info('Foreground service stopped');
  }

  Future<void> updateNotification(String title, String text) => FlutterForegroundTask.updateService(notificationTitle: title, notificationText: text);
}

@pragma('vm:entry-point')
void _taskCallback() {}
