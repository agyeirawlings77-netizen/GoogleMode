import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class FcmService {
  final FirebaseMessaging _fcm;
  FcmService(this._fcm);

  Future<void> initialize({
    required Function(RemoteMessage) onMessage,
    required Function(RemoteMessage) onMessageOpenedApp,
  }) async {
    await requestPermission();
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    final initial = await _fcm.getInitialMessage();
    if (initial != null) onMessageOpenedApp(initial);
    AppLogger.info('FCM initialized');
  }

  Future<NotificationSettings> requestPermission() => _fcm.requestPermission(alert: true, badge: true, sound: true, criticalAlert: false);

  Future<String?> getToken() async {
    try { return await _fcm.getToken(); }
    catch (e) { AppLogger.error('FCM token failed', e); return null; }
  }

  Future<void> deleteToken() => _fcm.deleteToken();

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<void> subscribeToTopic(String topic) => _fcm.subscribeToTopic(topic);
  Future<void> unsubscribeFromTopic(String topic) => _fcm.unsubscribeFromTopic(topic);

  Future<bool> isAutoInitEnabled() async => _fcm.isAutoInitEnabled;
}
