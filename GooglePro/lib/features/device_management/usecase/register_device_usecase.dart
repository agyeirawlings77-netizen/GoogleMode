import 'package:injectable/injectable.dart';
import '../model/device_model.dart';
import '../repository/device_repository.dart';

@injectable
class RegisterDeviceUsecase {
  final DeviceRepository _repo;
  RegisterDeviceUsecase(this._repo);
  Future<void> call(DeviceModel device) => _repo.registerDevice(device);
}
