import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class CrashReporter {
  Future<void> initialize() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) await setUserId(uid);
    AppLogger.info('Crash reporter initialized');
  }

  Future<void> setUserId(String uid) => FirebaseCrashlytics.instance.setUserIdentifier(uid);
  Future<void> log(String message) => FirebaseCrashlytics.instance.log(message);
  Future<void> setCustomKey(String key, String value) => FirebaseCrashlytics.instance.setCustomKey(key, value);
  Future<void> recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) => FirebaseCrashlytics.instance.recordError(exception, stack, fatal: fatal);
  Future<void> recordFlutterError(dynamic details) => FirebaseCrashlytics.instance.recordFlutterFatalError(details);
}
