import 'package:injectable/injectable.dart';
import '../repository/notification_repository.dart';
@injectable
class MarkNotificationReadUsecase {
  final NotificationRepository _repo;
  MarkNotificationReadUsecase(this._repo);
  Future<void> call(String id) => _repo.markRead(id);
}
