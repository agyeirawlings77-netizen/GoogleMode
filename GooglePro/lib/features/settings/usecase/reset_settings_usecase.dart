import 'package:injectable/injectable.dart';
import '../repository/settings_repository.dart';
@injectable
class ResetSettingsUsecase {
  final SettingsRepository _repo;
  ResetSettingsUsecase(this._repo);
  Future<void> call() => _repo.resetSettings();
}
