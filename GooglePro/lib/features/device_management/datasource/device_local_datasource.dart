import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/device_model.dart';

@singleton
class DeviceLocalDatasource {
  final SharedPreferences _prefs;
  static const _devicesKey = 'registered_devices';
  static const _thisDeviceKey = 'this_device';
  DeviceLocalDatasource(this._prefs);

  Future<void> saveDevices(List<DeviceModel> devices) async =>
    _prefs.setString(_devicesKey, jsonEncode(devices.map((d) => d.toJson()).toList()));

  List<DeviceModel> getDevices() {
    final raw = _prefs.getString(_devicesKey);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).map((e) => DeviceModel.fromJson(e)).toList(); }
    catch (_) { return []; }
  }

  Future<void> saveThisDevice(DeviceModel device) async =>
    _prefs.setString(_thisDeviceKey, jsonEncode(device.toJson()));

  DeviceModel? getThisDevice() {
    final raw = _prefs.getString(_thisDeviceKey);
    if (raw == null) return null;
    try { return DeviceModel.fromJson(jsonDecode(raw)); }
    catch (_) { return null; }
  }
}
