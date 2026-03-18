import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class HomeWidgetUpdater {
  Future<void> updateDeviceCount(int count) async {
    AppLogger.debug('Home widget: $count device(s) online');
    // Use home_widget package: HomeWidget.saveWidgetData('deviceCount', count);
  }
  Future<void> updateLastConnected(String deviceName) async {
    AppLogger.debug('Home widget: last = $deviceName');
    // HomeWidget.saveWidgetData('lastDevice', deviceName);
    // HomeWidget.updateWidget(androidName: 'GoogleProWidgetProvider');
  }
}
