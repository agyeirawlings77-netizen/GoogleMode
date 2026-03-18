import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotif = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    await _localNotif.initialize(const InitializationSettings(android: androidInit, iOS: iosInit), onDidReceiveNotificationResponse: _onNotifTapped);
    await _createChannels();
    FirebaseMessaging.onMessage.listen(_onFcmMessage);
    _initialized = true;
    AppLogger.info('NotificationService initialized');
  }

  Future<String?> getFcmToken() async {
    try { return await _fcm.getToken(); }
    catch (e) { AppLogger.error('FCM token failed', e); return null; }
  }

  Future<void> showConnectionNotification({required String deviceName, required bool connected}) async {
    await _show(id: 100, title: connected ? 'Connected' : 'Disconnected', body: connected ? 'Connected to $deviceName' : '$deviceName disconnected', channelId: AppConstants.channelConnection);
  }

  Future<void> showMessageNotification({required String senderName, required String message}) async {
    await _show(id: 200, title: senderName, body: message, channelId: AppConstants.channelDefault);
  }

  Future<void> showAlertNotification({required String title, required String body}) async {
    await _show(id: 300, title: title, body: body, channelId: AppConstants.channelAlert, importance: Importance.high, priority: Priority.high);
  }

  Future<void> _show({required int id, required String title, required String body, required String channelId, Importance importance = Importance.defaultImportance, Priority priority = Priority.defaultPriority}) async {
    await _localNotif.show(id, title, body, NotificationDetails(android: AndroidNotificationDetails(channelId, channelId, importance: importance, priority: priority, icon: '@mipmap/ic_launcher'), iOS: const DarwinNotificationDetails()));
  }

  Future<void> _createChannels() async {
    final plugin = _localNotif.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final channels = [
      AndroidNotificationChannel(AppConstants.channelDefault, 'Default', importance: Importance.defaultImportance),
      AndroidNotificationChannel(AppConstants.channelConnection, 'Connections', importance: Importance.low),
      AndroidNotificationChannel(AppConstants.channelAlert, 'Alerts', importance: Importance.high),
    ];
    for (final ch in channels) await plugin?.createNotificationChannel(ch);
  }

  Future<void> requestPermission() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true, criticalAlert: false);
  }

  void _onNotifTapped(NotificationResponse r) => AppLogger.info('Notification tapped: ${r.id}');

  void _onFcmMessage(RemoteMessage msg) {
    AppLogger.info('FCM foreground: ${msg.messageId}');
    final notif = msg.notification;
    if (notif != null) _show(id: msg.hashCode, title: notif.title ?? '', body: notif.body ?? '', channelId: AppConstants.channelDefault);
  }
}
