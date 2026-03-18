import '../model/security_alert.dart';
import '../model/security_settings.dart';
abstract class SecurityRepository {
  Future<SecuritySettings> getSettings();
  Future<void> saveSettings(SecuritySettings s);
  Future<List<SecurityAlert>> getAlerts(String deviceId);
  Future<void> markAlertRead(String alertId);
}
