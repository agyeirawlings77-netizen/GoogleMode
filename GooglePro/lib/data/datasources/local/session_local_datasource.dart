import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/session_model.dart';

@singleton
class SessionLocalDatasource {
  final SharedPreferences _prefs;
  static const _historyKey = 'session_history_v1';
  SessionLocalDatasource(this._prefs);

  Future<void> saveToHistory(SessionModel session) async {
    final history = getHistory();
    history.insert(0, session);
    if (history.length > 100) history.removeLast();
    await _prefs.setString(_historyKey, jsonEncode(history.map((s) => s.toJson()).toList()));
  }
  List<SessionModel> getHistory() { final r = _prefs.getString(_historyKey); if (r == null) return []; try { return (jsonDecode(r) as List).map((e) => SessionModel.fromJson(e)).toList(); } catch (_) { return []; } }
  Future<void> clearHistory() => _prefs.remove(_historyKey);
}
