import 'package:injectable/injectable.dart';
import '../model/security_settings.dart';
import '../service/security_service.dart';
@injectable
class GetSecuritySettingsUsecase {
  final SecurityService _svc;
  GetSecuritySettingsUsecase(this._svc);
  Future<SecuritySettings> call() => _svc.getSettings();
}
