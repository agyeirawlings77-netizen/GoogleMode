import 'package:injectable/injectable.dart';
import '../repository/parental_repository.dart';
@injectable
class LockDeviceUsecase {
  final ParentalRepository _repo;
  LockDeviceUsecase(this._repo);
  Future<void> call(String deviceId) => _repo.lockDevice(deviceId);
}
