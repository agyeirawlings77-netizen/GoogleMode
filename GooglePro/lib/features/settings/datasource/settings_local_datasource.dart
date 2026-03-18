import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/app_settings.dart';

@singleton
class SettingsLocalDatasource {
  final SharedPreferences _prefs;
  static const _key = 'app_settings_v2';
  SettingsLocalDatasource(this._prefs);

  AppSettings load() {
    final raw = _prefs.getString(_key);
    if (raw == null) return const AppSettings();
    try { return AppSettings.fromJson(jsonDecode(raw)); }
    catch (_) { return const AppSettings(); }
  }

  Future<void> save(AppSettings s) => _prefs.setString(_key, jsonEncode(s.toJson()));
  Future<void> reset() => _prefs.remove(_key);
}
