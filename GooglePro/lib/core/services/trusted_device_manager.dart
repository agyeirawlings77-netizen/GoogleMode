import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';
import '../../features/trusted_device/model/trusted_device_model.dart';

@singleton
class TrustedDeviceManager {
  final FlutterSecureStorage _storage;
  TrustedDeviceManager(this._storage);

  Future<void> saveTrustedDevice(TrustedDeviceModel device) async {
    try {
      final devices = await getAllTrustedDevices();
      final idx = devices.indexWhere((d) => d.deviceId == device.deviceId);
      if (idx >= 0) {
        devices[idx] = device.copyWith(lastConnectedAt: DateTime.now());
      } else {
        devices.add(device.copyWith(savedAt: DateTime.now(), lastConnectedAt: DateTime.now()));
        AppLogger.info('Saved trusted: ${device.deviceName}');
      }
      await _saveAll(devices);
    } catch (e, s) { AppLogger.error('Save trusted failed', e, s); }
  }

  Future<bool> isTrusted(String deviceId) async =>
      (await getAllTrustedDevices()).any((d) => d.deviceId == deviceId);

  Future<TrustedDeviceModel?> getTrustedDevice(String deviceId) async {
    try { return (await getAllTrustedDevices()).firstWhere((d) => d.deviceId == deviceId); }
    catch (_) { return null; }
  }

  Future<List<TrustedDeviceModel>> getAllTrustedDevices() async {
    try {
      final raw = await _storage.read(key: AppConstants.trustedDevicesKey);
      if (raw == null) return [];
      return (jsonDecode(raw) as List).map((e) => TrustedDeviceModel.fromJson(e)).toList();
    } catch (e) { AppLogger.error('Read trusted failed', e); return []; }
  }

  Future<void> removeTrustedDevice(String deviceId) async {
    final devices = await getAllTrustedDevices();
    devices.removeWhere((d) => d.deviceId == deviceId);
    await _saveAll(devices);
  }

  Future<void> updateLastConnected(String deviceId) async {
    final devices = await getAllTrustedDevices();
    final idx = devices.indexWhere((d) => d.deviceId == deviceId);
    if (idx >= 0) { devices[idx] = devices[idx].copyWith(lastConnectedAt: DateTime.now()); await _saveAll(devices); }
  }

  Future<void> clearAll() async => _storage.delete(key: AppConstants.trustedDevicesKey);

  Future<void> _saveAll(List<TrustedDeviceModel> devices) async =>
      _storage.write(key: AppConstants.trustedDevicesKey, value: jsonEncode(devices.map((d) => d.toJson()).toList()));
}
