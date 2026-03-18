import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

@singleton
class PushNotificationService {
  final _localNotif = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotif.initialize(const InitializationSettings(android: androidInit), onDidReceiveNotificationResponse: (r) => AppLogger.info('Notification tapped: ${r.id}'));
    await _createChannels();
    _initialized = true;
    AppLogger.info('Push notifications initialized');
  }

  Future<String?> getToken() async {
    try { return await FirebaseMessaging.instance.getToken(); }
    catch (e) { AppLogger.error('FCM token failed', e); return null; }
  }

  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> show({required int id, required String title, required String body, String channelId = AppConstants.channelDefault}) async {
    await _localNotif.show(id, title, body, NotificationDetails(android: AndroidNotificationDetails(channelId, channelId, importance: Importance.high, priority: Priority.high, icon: '@mipmap/ic_launcher')));
  }

  Future<void> showConnection(String deviceName, bool connected) =>
    show(id: 100, title: connected ? 'Connected' : 'Disconnected', body: connected ? 'Connected to $deviceName' : '$deviceName disconnected', channelId: AppConstants.channelConnection);

  Future<void> showMessage(String from, String body) => show(id: 200, title: from, body: body);
  Future<void> showAlert(String title, String body) => show(id: 300, title: title, body: body, channelId: AppConstants.channelAlert);

  Future<void> _createChannels() async {
    final plugin = _localNotif.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final channels = [
      const AndroidNotificationChannel(AppConstants.channelDefault, 'Default', importance: Importance.high),
      const AndroidNotificationChannel(AppConstants.channelConnection, 'Connections', importance: Importance.low),
      const AndroidNotificationChannel(AppConstants.channelAlert, 'Alerts', importance: Importance.high),
    ];
    for (final ch in channels) await plugin?.createNotificationChannel(ch);
  }
}
