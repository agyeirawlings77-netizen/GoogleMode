import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;
  CrashlyticsService(this._crashlytics);

  Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) await setUserId(uid);
    AppLogger.info('Crashlytics initialized');
  }

  Future<void> setUserId(String uid) => _crashlytics.setUserIdentifier(uid);
  Future<void> log(String message) => _crashlytics.log(message);
  Future<void> recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) => _crashlytics.recordError(exception, stack, fatal: fatal);
  Future<void> setCustomKey(String key, dynamic value) => _crashlytics.setCustomKey(key, value.toString());
}
