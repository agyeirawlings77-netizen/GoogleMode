import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/session_model.dart';
@singleton
class SessionLocalDatasource {
  final SharedPreferences _prefs;
  static const _historyKey = 'session_history';
  SessionLocalDatasource(this._prefs);
  Future<void> saveSession(SessionModel s) async {
    final list = getSessions();
    list.insert(0, s);
    if (list.length > 100) list.removeLast();
    await _prefs.setString(_historyKey, jsonEncode(list.map((s) => s.toJson()).toList()));
  }
  List<SessionModel> getSessions() {
    final raw = _prefs.getString(_historyKey);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).map((e) => SessionModel.fromJson(e)).toList(); } catch (_) { return []; }
  }
}
