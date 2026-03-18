import 'package:injectable/injectable.dart';
import '../model/parental_profile.dart';
import '../repository/parental_repository.dart';
@injectable
class SaveProfileUsecase {
  final ParentalRepository _repo;
  SaveProfileUsecase(this._repo);
  Future<void> call(ParentalProfile profile) => _repo.saveProfile(profile);
}
