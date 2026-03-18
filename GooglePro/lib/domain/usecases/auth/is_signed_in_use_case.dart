import 'package:injectable/injectable.dart';
import '../../repositories/i_auth_repository.dart';
@injectable
class IsSignedInUseCase {
  final IAuthRepository _repo;
  IsSignedInUseCase(this._repo);
  Future<bool> call() => _repo.isSignedIn();
}
