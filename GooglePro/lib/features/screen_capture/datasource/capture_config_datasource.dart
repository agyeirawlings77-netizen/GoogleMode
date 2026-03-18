import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/capture_config.dart';
@singleton
class CaptureConfigDatasource {
  final SharedPreferences _prefs;
  static const _key = 'capture_config';
  CaptureConfigDatasource(this._prefs);
  Future<void> save(CaptureConfig c) => _prefs.setString(_key, jsonEncode(c.toJson()));
  CaptureConfig get() { final raw = _prefs.getString(_key); if (raw == null) return const CaptureConfig(); try { final j = jsonDecode(raw); return CaptureConfig(fps: j['fps'] ?? 15, bitrateKbps: j['bitrateKbps'] ?? 2000); } catch (_) { return const CaptureConfig(); } }
}
