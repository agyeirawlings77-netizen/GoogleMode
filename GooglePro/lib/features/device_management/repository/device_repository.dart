import '../model/device_model_local.dart';
abstract class DeviceRepository {
  Future<List<DeviceModelLocal>> getDevices(String uid);
  Future<void> renameDevice(String id, String name);
  Future<void> deleteDevice(String id);
  Stream<List<DeviceModelLocal>> watchDevices(String uid);
}
