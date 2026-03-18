import 'package:injectable/injectable.dart';
import '../model/app_settings.dart';
import '../repository/settings_repository.dart';
@injectable
class SaveSettingsUsecase {
  final SettingsRepository _repo;
  SaveSettingsUsecase(this._repo);
  Future<void> call(AppSettings s) => _repo.saveSettings(s);
}
