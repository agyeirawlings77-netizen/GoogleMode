import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../datasources/remote/device_remote_datasource.dart';
import '../datasources/local/device_local_datasource.dart';
import '../models/device_model.dart';
import '../../domain/entities/device_entity.dart';
import '../../domain/repositories/i_device_repository.dart';
import '../../core/utils/app_logger.dart';

@LazySingleton(as: IDeviceRepository)
class DeviceRepositoryImpl implements IDeviceRepository {
  final DeviceRemoteDatasource _remote;
  final DeviceLocalDatasource _local;
  DeviceRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<String, List<DeviceEntity>>> getDevices() async {
    try { return Right(await _remote.getDevices()); }
    catch (_) { return Right(_local.getDevices()); }
  }

  @override
  Future<Either<String, DeviceEntity>> registerDevice(DeviceEntity device) async {
    try {
      final model = DeviceModel(deviceId: device.deviceId, deviceName: device.deviceName, type: device.type, ownerUserId: device.ownerUserId, status: device.status, fcmToken: device.fcmToken, osVersion: device.osVersion, appVersion: device.appVersion, batteryLevel: device.batteryLevel);
      await _remote.registerDevice(model);
      await _local.saveThisDevice(model);
      return Right(model);
    } catch (e) { return Left(e.toString()); }
  }

  @override
  Future<Either<String, void>> removeDevice(String deviceId) async {
    try { await _remote.deleteDevice(deviceId); return const Right(null); }
    catch (e) { return Left(e.toString()); }
  }

  @override
  Future<Either<String, void>> renameDevice(String deviceId, String name) async {
    try { await _remote.updateDevice(deviceId, {'deviceName': name}); return const Right(null); }
    catch (e) { return Left(e.toString()); }
  }

  @override
  Future<DeviceEntity?> getThisDevice() async {
    final cached = _local.getThisDevice();
    if (cached != null) return cached;
    try {
      final info = await DeviceInfoPlugin().androidInfo;
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      return DeviceModel(deviceId: const Uuid().v4(), deviceName: '${info.manufacturer} ${info.model}', type: DeviceType.phone, ownerUserId: uid, osVersion: info.version.release, appVersion: '1.0.0');
    } catch (e) { AppLogger.error('getThisDevice failed', e); return null; }
  }

  @override Stream<List<DeviceEntity>> watchDevices() => _remote.watchDevices().map((list) => list);
  @override Stream<bool> watchOnlineStatus(String uid, String deviceId) => _remote.watchPresence(uid, deviceId);

  @override
  Future<Either<String, void>> updateFcmToken(String deviceId, String token) async {
    try { await _remote.updateDevice(deviceId, {'fcmToken': token}); return const Right(null); }
    catch (e) { return Left(e.toString()); }
  }
}
