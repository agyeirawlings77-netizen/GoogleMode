import 'package:injectable/injectable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/i_notification_repository.dart';
import '../../features/notifications/service/notification_service.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationService _svc;
  NotificationRepositoryImpl(this._svc);
  @override Future<List<NotificationEntity>> getNotifications() async => [];
  @override Future<void> markRead(String id) async {}
  @override Future<void> markAllRead() async {}
  @override Future<void> clearAll() async {}
  @override Future<String?> getFcmToken() => _svc.getFcmToken();
  @override Future<void> saveFcmToken(String token) async {}
}
