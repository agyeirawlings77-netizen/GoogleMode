import 'package:injectable/injectable.dart';
import '../repository/parental_repository.dart';
@injectable
class BlockAppUsecase {
  final ParentalRepository _repo;
  BlockAppUsecase(this._repo);
  Future<void> block(String profileId, String pkg) => _repo.blockApp(profileId, pkg);
  Future<void> unblock(String profileId, String pkg) => _repo.unblockApp(profileId, pkg);
}
