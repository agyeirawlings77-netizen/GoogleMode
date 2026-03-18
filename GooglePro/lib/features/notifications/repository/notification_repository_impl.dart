import 'package:injectable/injectable.dart';
import '../datasource/notification_local_datasource.dart';
import '../model/app_notification.dart';
import 'notification_repository.dart';
@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDatasource _local;
  NotificationRepositoryImpl(this._local);
  @override Future<List<AppNotification>> getNotifications() async => _local.load();
  @override Future<void> markRead(String id) async { final n = _local.load(); await _local.save(n.map((e) => e.notificationId == id ? e.markRead() : e).toList()); }
  @override Future<void> clearAll() => _local.clear();
  @override Future<void> save(List<AppNotification> n) => _local.save(n);
}
