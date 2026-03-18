import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:workmanager/workmanager.dart';
import '../constants/app_constants.dart';
import '../di/injection.dart';
import '../firebase/firebase_options.dart';
import '../router/app_router.dart';
import '../services/auto_connect_worker.dart';
import '../services/foreground_task_handler.dart';
import '../theme/app_theme.dart';
import '../utils/app_logger.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppLogger.info('FCM background: ${message.messageId}');
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    AppLogger.info('WorkManager: $taskName');
    switch (taskName) {
      case AutoConnectWorker.taskName:
        return AutoConnectWorker.execute(inputData ?? {});
      default:
        return true;
    }
  });
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

class MyApplication {
  static Future<void> init() async {
    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));

      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await configureDependencies();

      await Workmanager().initialize(callbackDispatcher,
          isInDebugMode: kDebugMode);

      await Workmanager().registerPeriodicTask(
        AutoConnectWorker.uniqueName,
        AutoConnectWorker.taskName,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.keep,
        backoffPolicy: BackoffPolicy.exponential,
      );

      runApp(const GoogleProApp());
    }, (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      AppLogger.error('Uncaught', error, stack);
    });
  }
}

class GoogleProApp extends StatelessWidget {
  const GoogleProApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router.config(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2)),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
