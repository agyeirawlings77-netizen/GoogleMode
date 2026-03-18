import '../model/trusted_device_model.dart';

abstract class TrustedDeviceRepository {
  Future<List<TrustedDeviceModel>> getAll();
  Future<void> save(TrustedDeviceModel device);
  Future<void> remove(String deviceId);
  Future<bool> isTrusted(String deviceId);
  Future<TrustedDeviceModel?> get(String deviceId);
  Future<void> updateAutoConnect(String deviceId, bool autoConnect);
  Future<void> updateLastConnected(String deviceId);
  Stream<bool> watchOnlineStatus(String ownerUserId, String deviceId);
}
