import '../model/app_settings.dart';
abstract class SettingsRepository {
  AppSettings getSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<void> resetSettings();
}
