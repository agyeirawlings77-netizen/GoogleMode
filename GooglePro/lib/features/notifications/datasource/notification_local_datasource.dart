import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/app_notification.dart';
@singleton
class NotificationLocalDatasource {
  final SharedPreferences _prefs;
  static const _key = 'notifications_cache';
  NotificationLocalDatasource(this._prefs);
  Future<void> save(List<AppNotification> notifs) => _prefs.setString(_key, jsonEncode(notifs.map((n) => n.toJson()).toList()));
  List<AppNotification> load() {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).map((e) => AppNotification.fromJson(e)).toList(); } catch (_) { return []; }
  }
  Future<void> clear() => _prefs.remove(_key);
}
