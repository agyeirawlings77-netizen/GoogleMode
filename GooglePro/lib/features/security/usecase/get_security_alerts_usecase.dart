import 'package:injectable/injectable.dart';
import '../model/security_alert.dart';
import '../service/security_service.dart';
@injectable
class GetSecurityAlertsUsecase {
  final SecurityService _svc;
  GetSecurityAlertsUsecase(this._svc);
  Future<SecurityAlert> createAlert(String deviceId, AlertType type, AlertSeverity severity, String description) =>
    _svc.createAlert(deviceId, type, severity, description);
}
