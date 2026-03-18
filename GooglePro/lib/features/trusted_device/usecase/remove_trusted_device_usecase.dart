import 'package:injectable/injectable.dart';
import '../repository/trusted_device_repository.dart';

@injectable
class RemoveTrustedDeviceUsecase {
  final TrustedDeviceRepository _repo;
  RemoveTrustedDeviceUsecase(this._repo);
  Future<void> call(String deviceId) => _repo.remove(deviceId);
}
