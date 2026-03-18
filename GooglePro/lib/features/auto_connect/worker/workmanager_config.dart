import 'package:workmanager/workmanager.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    AppLogger.info('WorkManager task: $task');
    switch (task) {
      case AppConstants.wmAutoConnect:
        // Check trusted devices and signal auto-connect
        // This runs in background, minimal work only
        return true;
      case AppConstants.wmSync:
        // Sync device status to Firebase
        return true;
      case AppConstants.wmCleanup:
        // Clean stale signals older than 1 hour
        return true;
    }
    return true;
  });
}

class WorkManagerConfig {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    AppLogger.info('WorkManager initialized');
  }

  static Future<void> scheduleAutoConnect() async {
    await Workmanager().registerPeriodicTask(
      AppConstants.wmAutoConnectUnique,
      AppConstants.wmAutoConnect,
      frequency: const Duration(minutes: AppConstants.autoConnectIntervalMinutes),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }

  static Future<void> scheduleSync() async {
    await Workmanager().registerOneOffTask('${AppConstants.wmSync}_${DateTime.now().millisecondsSinceEpoch}', AppConstants.wmSync, constraints: Constraints(networkType: NetworkType.connected));
  }

  static Future<void> cancelAll() => Workmanager().cancelAll();
}
