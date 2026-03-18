import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@singleton
class FileTransferLocalDatasource {
  final SharedPreferences _prefs;
  static const _key = 'file_transfer_history';
  FileTransferLocalDatasource(this._prefs);
  Future<void> save(Map<String, dynamic> transfer) async {
    final raw = _prefs.getString(_key);
    final list = raw != null ? jsonDecode(raw) as List : [];
    list.insert(0, transfer);
    if (list.length > 200) list.removeLast();
    await _prefs.setString(_key, jsonEncode(list));
  }
  List<Map<String, dynamic>> getAll() {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) { return []; }
  }
}
