import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/trusted_device_manager.dart';
import '../model/trusted_device_model.dart';
import 'trusted_device_repository.dart';

@LazySingleton(as: TrustedDeviceRepository)
class TrustedDeviceRepositoryImpl implements TrustedDeviceRepository {
  final TrustedDeviceManager _manager;
  TrustedDeviceRepositoryImpl(this._manager);

  @override Future<List<TrustedDeviceModel>> getAll() => _manager.getAllTrustedDevices();
  @override Future<void> save(TrustedDeviceModel device) => _manager.saveTrustedDevice(device);
  @override Future<void> remove(String id) => _manager.removeTrustedDevice(id);
  @override Future<bool> isTrusted(String id) => _manager.isTrusted(id);
  @override Future<TrustedDeviceModel?> get(String id) => _manager.getTrustedDevice(id);
  @override Future<void> updateLastConnected(String id) => _manager.updateLastConnected(id);

  @override
  Future<void> updateAutoConnect(String deviceId, bool autoConnect) async {
    final devices = await _manager.getAllTrustedDevices();
    final idx = devices.indexWhere((d) => d.deviceId == deviceId);
    if (idx >= 0) await _manager.saveTrustedDevice(devices[idx].copyWith(autoConnect: autoConnect));
  }

  @override
  Stream<bool> watchOnlineStatus(String ownerUserId, String deviceId) =>
    FirebaseDatabase.instance
      .ref('${AppConstants.presencePath}/$ownerUserId/$deviceId/online')
      .onValue
      .map((e) => e.snapshot.value as bool? ?? false);
}
