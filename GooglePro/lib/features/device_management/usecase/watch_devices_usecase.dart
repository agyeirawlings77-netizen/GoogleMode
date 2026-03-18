import 'package:injectable/injectable.dart';
import '../model/device_model.dart';
import '../repository/device_repository.dart';
@injectable
class WatchDevicesUsecase {
  final DeviceRepository _repo;
  WatchDevicesUsecase(this._repo);
  Stream<List<DeviceModel>> call() => _repo.watchDevices();
}
