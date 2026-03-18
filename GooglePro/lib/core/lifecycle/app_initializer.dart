import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../firebase/firebase_initializer.dart';
import '../firebase/firebase_config.dart';
import '../firebase/fcm_handler.dart';
import '../di/injection.dart';
import '../platform/platform_info.dart';
import '../platform/battery_service.dart';
import '../platform/connectivity_service.dart';
import '../services/push_notification_service.dart';
import '../utils/app_logger.dart';

@singleton
class AppInitializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      navigationBarColor: Color(0xFF0A0E1A),
      navigationBarIconBrightness: Brightness.light,
    ));

    // Firebase
    await FirebaseInitializer.initialize();
    await FirebaseInitializer.configureCrashlytics();
    await FirebaseInitializer.configureFcm();
    await FirebaseConfig.init();
    FcmHandler.listenForeground();

    // DI
    await configureDependencies();

    // Platform
    await getIt<PlatformInfo>().initialize();
    await getIt<BatteryService>().initialize();
    await getIt<ConnectivityService>().initialize();

    // Notifications
    final notifSvc = getIt<PushNotificationService>();
    await notifSvc.initialize();
    await notifSvc.requestPermission();

    AppLogger.info('App initialized ✓');
  }
}
