import 'package:injectable/injectable.dart';
import '../model/device_model.dart';
import '../repository/device_repository.dart';

@injectable
class GetDevicesUsecase {
  final DeviceRepository _repo;
  GetDevicesUsecase(this._repo);
  Future<List<DeviceModel>> call() => _repo.getDevices();
}
