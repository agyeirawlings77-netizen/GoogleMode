import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class AnalyticsService {
  final FirebaseAnalytics _analytics;
  AnalyticsService(this._analytics);

  Future<void> logEvent(String name, {Map<String, dynamic>? params}) async {
    try {
      await _analytics.logEvent(name: name, parameters: params?.map((k, v) => MapEntry(k, v?.toString() ?? '')));
      AppLogger.debug('Analytics: $name');
    } catch (e) { AppLogger.warning('Analytics failed: $e'); }
  }

  Future<void> setUserId(String? uid) => _analytics.setUserId(id: uid);
  Future<void> logLogin(String method) => logEvent('login', params: {'method': method});
  Future<void> logSessionStarted(String sessionType) => logEvent('session_started', params: {'type': sessionType});
  Future<void> logSessionEnded(int durationSeconds) => logEvent('session_ended', params: {'duration_seconds': durationSeconds.toString()});
  Future<void> logFileTransfer(int fileSizeBytes) => logEvent('file_transfer', params: {'size_bytes': fileSizeBytes.toString()});
  Future<void> logFeatureUsed(String feature) => logEvent('feature_used', params: {'name': feature});
  Future<void> setUserProperty(String name, String value) => _analytics.setUserProperty(name: name, value: value);
}
