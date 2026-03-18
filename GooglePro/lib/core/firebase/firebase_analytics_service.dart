import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics;
  FirebaseAnalyticsService(this._analytics);

  FirebaseAnalyticsObserver get observer => FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> logEvent(String name, {Map<String, dynamic>? params}) async {
    try { await _analytics.logEvent(name: name, parameters: params?.map((k, v) => MapEntry(k, v?.toString() ?? ''))); }
    catch (e) { AppLogger.warning('Analytics event failed: $e'); }
  }

  Future<void> setUserId(String uid) => _analytics.setUserId(id: uid);
  Future<void> logLogin(String method) => _analytics.logLogin(loginMethod: method);
  Future<void> logScreenView(String screenName) => _analytics.logScreenView(screenName: screenName);
  Future<void> setUserProperty(String name, String value) => _analytics.setUserProperty(name: name, value: value);
}
