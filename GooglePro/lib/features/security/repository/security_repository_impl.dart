import 'package:injectable/injectable.dart';
import '../service/security_service.dart';
import '../model/security_alert.dart';
import '../model/security_settings.dart';
import 'security_repository.dart';
@LazySingleton(as: SecurityRepository)
class SecurityRepositoryImpl implements SecurityRepository {
  final SecurityService _svc;
  SecurityRepositoryImpl(this._svc);
  @override Future<SecuritySettings> getSettings() => _svc.getSettings();
  @override Future<void> saveSettings(SecuritySettings s) => _svc.saveSettings(s);
  @override Future<List<SecurityAlert>> getAlerts(String deviceId) async => [];
  @override Future<void> markAlertRead(String alertId) async {}
}
