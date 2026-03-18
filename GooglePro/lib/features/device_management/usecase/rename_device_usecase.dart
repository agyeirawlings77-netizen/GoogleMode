import 'package:injectable/injectable.dart';
import '../repository/device_repository.dart';
@injectable
class RenameDeviceUsecase {
  final DeviceRepository _repo;
  RenameDeviceUsecase(this._repo);
  Future<void> call(String deviceId, String name) => _repo.renameDevice(deviceId, name);
}
