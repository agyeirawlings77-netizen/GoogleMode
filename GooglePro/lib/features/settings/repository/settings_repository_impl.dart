import 'package:injectable/injectable.dart';
import '../datasource/settings_local_datasource.dart';
import '../model/app_settings.dart';
import 'settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _local;
  SettingsRepositoryImpl(this._local);
  @override AppSettings getSettings() => _local.load();
  @override Future<void> saveSettings(AppSettings s) => _local.save(s);
  @override Future<void> resetSettings() => _local.reset();
}
