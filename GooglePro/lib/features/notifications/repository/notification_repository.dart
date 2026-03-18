import '../model/app_notification.dart';
abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<void> markRead(String notificationId);
  Future<void> clearAll();
  Future<void> save(List<AppNotification> notifs);
}
