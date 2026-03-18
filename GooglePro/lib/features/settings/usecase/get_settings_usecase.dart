import 'package:injectable/injectable.dart';
import '../model/app_settings.dart';
import '../repository/settings_repository.dart';
@injectable
class GetSettingsUsecase {
  final SettingsRepository _repo;
  GetSettingsUsecase(this._repo);
  AppSettings call() => _repo.getSettings();
}
