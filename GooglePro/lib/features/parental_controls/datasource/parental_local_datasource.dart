import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/parental_profile.dart';
@singleton
class ParentalLocalDatasource {
  final SharedPreferences _prefs;
  static const _key = 'parental_profile';
  ParentalLocalDatasource(this._prefs);
  Future<void> save(ParentalProfile p) => _prefs.setString(_key, jsonEncode(p.toJson()));
  ParentalProfile? get() { final r = _prefs.getString(_key); if (r == null) return null; try { return ParentalProfile.fromJson(jsonDecode(r)); } catch (_) { return null; } }
}
