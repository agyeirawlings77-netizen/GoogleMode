import 'package:injectable/injectable.dart';
import '../service/notification_service.dart';
@injectable
class SendNotificationUsecase {
  final NotificationService _svc;
  SendNotificationUsecase(this._svc);
  Future<void> connection(String deviceName, bool connected) => _svc.showConnectionNotification(deviceName: deviceName, connected: connected);
  Future<void> message(String sender, String body) => _svc.showMessageNotification(senderName: sender, message: body);
  Future<void> alert(String title, String body) => _svc.showAlertNotification(title: title, body: body);
}
