import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../model/trusted_device_model.dart';

@singleton
class TrustedDeviceLocalDatasource {
  final FlutterSecureStorage _storage;
  TrustedDeviceLocalDatasource(this._storage);

  Future<List<TrustedDeviceModel>> getAll() async {
    final raw = await _storage.read(key: AppConstants.trustedDevicesKey);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).map((e) => TrustedDeviceModel.fromJson(e)).toList(); }
    catch (_) { return []; }
  }

  Future<void> saveAll(List<TrustedDeviceModel> devices) async =>
    _storage.write(key: AppConstants.trustedDevicesKey, value: jsonEncode(devices.map((d) => d.toJson()).toList()));

  Future<void> clear() => _storage.delete(key: AppConstants.trustedDevicesKey);
}
