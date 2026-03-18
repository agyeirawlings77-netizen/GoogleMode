import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/device_model.dart';

@singleton
class DeviceLocalDatasource {
  final SharedPreferences _prefs;
  static const _devicesKey = 'cached_devices_v1';
  static const _thisDeviceKey = 'this_device_v1';
  DeviceLocalDatasource(this._prefs);

  Future<void> saveDevices(List<DeviceModel> devices) => _prefs.setString(_devicesKey, jsonEncode(devices.map((d) => d.toJson()).toList()));
  List<DeviceModel> getDevices() { final r = _prefs.getString(_devicesKey); if (r == null) return []; try { return (jsonDecode(r) as List).map((e) => DeviceModel.fromJson(e)).toList(); } catch (_) { return []; } }
  Future<void> saveThisDevice(DeviceModel d) => _prefs.setString(_thisDeviceKey, jsonEncode(d.toJson()));
  DeviceModel? getThisDevice() { final r = _prefs.getString(_thisDeviceKey); if (r == null) return null; try { return DeviceModel.fromJson(jsonDecode(r)); } catch (_) { return null; } }
  Future<void> clear() async { await _prefs.remove(_devicesKey); await _prefs.remove(_thisDeviceKey); }
}
