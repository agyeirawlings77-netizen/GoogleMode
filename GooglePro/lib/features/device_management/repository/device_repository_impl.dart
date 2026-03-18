import 'package:injectable/injectable.dart';
import '../service/device_service.dart';
import '../model/device_model_local.dart';
import 'device_repository.dart';
@LazySingleton(as: DeviceRepository)
class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceService _svc;
  DeviceRepositoryImpl(this._svc);
  @override Future<List<DeviceModelLocal>> getDevices(String uid) => _svc.getDevices(uid);
  @override Future<void> renameDevice(String id, String name) => _svc.renameDevice(id, name);
  @override Future<void> deleteDevice(String id) => _svc.deleteDevice(id);
  @override Stream<List<DeviceModelLocal>> watchDevices(String uid) => _svc.watchDevices(uid);
}
