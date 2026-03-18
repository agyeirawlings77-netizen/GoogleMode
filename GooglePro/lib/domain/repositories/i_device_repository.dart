import 'package:dartz/dartz.dart';
import '../entities/device_entity.dart';

abstract class IDeviceRepository {
  Future<Either<String, List<DeviceEntity>>> getDevices();
  Future<Either<String, DeviceEntity>> registerDevice(DeviceEntity device);
  Future<Either<String, void>> removeDevice(String deviceId);
  Future<Either<String, void>> renameDevice(String deviceId, String name);
  Future<DeviceEntity?> getThisDevice();
  Stream<List<DeviceEntity>> watchDevices();
  Stream<bool> watchOnlineStatus(String uid, String deviceId);
  Future<Either<String, void>> updateFcmToken(String deviceId, String token);
}
