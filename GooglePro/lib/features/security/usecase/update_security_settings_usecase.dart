import 'package:injectable/injectable.dart';
import '../model/security_settings.dart';
import '../service/security_service.dart';
@injectable
class UpdateSecuritySettingsUsecase {
  final SecurityService _svc;
  UpdateSecuritySettingsUsecase(this._svc);
  Future<void> call(SecuritySettings settings) => _svc.saveSettings(settings);
}
