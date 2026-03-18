import 'package:injectable/injectable.dart';
import '../repository/device_repository.dart';
@injectable
class RemoveDeviceUsecase {
  final DeviceRepository _repo;
  RemoveDeviceUsecase(this._repo);
  Future<void> call(String deviceId) => _repo.removeDevice(deviceId);
}
