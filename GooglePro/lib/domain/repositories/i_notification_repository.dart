import '../entities/notification_entity.dart';

abstract class INotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
  Future<void> markRead(String id);
  Future<void> markAllRead();
  Future<void> clearAll();
  Future<String?> getFcmToken();
  Future<void> saveFcmToken(String token);
}
