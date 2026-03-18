import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../model/trusted_device.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class TrustedDeviceManager {
  final FlutterSecureStorage _storage;
  TrustedDeviceManager(this._storage);

  Future<List<TrustedDevice>> getTrustedDevices() async {
    final raw = await _storage.read(key: AppConstants.trustedDevicesKey);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => TrustedDevice.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) { AppLogger.error('Load trusted devices failed', e); return []; }
  }

  Future<void> saveTrustedDevice(TrustedDevice device) async {
    final devices = await getTrustedDevices();
    final idx = devices.indexWhere((d) => d.deviceId == device.deviceId);
    if (idx >= 0) devices[idx] = device;
    else devices.add(device);
    await _storage.write(key: AppConstants.trustedDevicesKey, value: jsonEncode(devices.map((d) => d.toJson()).toList()));
    AppLogger.info('Trusted device saved: ${device.deviceName}');
  }

  Future<bool> isTrusted(String deviceId) async {
    final devices = await getTrustedDevices();
    return devices.any((d) => d.deviceId == deviceId && d.autoConnect);
  }

  Future<TrustedDevice?> getTrustedDevice(String deviceId) async {
    final devices = await getTrustedDevices();
    try { return devices.firstWhere((d) => d.deviceId == deviceId); }
    catch (_) { return null; }
  }

  Future<void> removeDevice(String deviceId) async {
    final devices = await getTrustedDevices();
    devices.removeWhere((d) => d.deviceId == deviceId);
    await _storage.write(key: AppConstants.trustedDevicesKey, value: jsonEncode(devices.map((d) => d.toJson()).toList()));
    AppLogger.info('Trusted device removed: $deviceId');
  }

  Future<void> updateFcmToken(String deviceId, String token) async {
    final device = await getTrustedDevice(deviceId);
    if (device != null) await saveTrustedDevice(device.copyWith(fcmToken: token));
  }

  Future<void> clearAll() => _storage.delete(key: AppConstants.trustedDevicesKey);
}
