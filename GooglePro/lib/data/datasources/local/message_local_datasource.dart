import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/message_model.dart';

@singleton
class MessageLocalDatasource {
  final SharedPreferences _prefs;
  MessageLocalDatasource(this._prefs);

  String _key(String sessionId) => 'messages_$sessionId';

  Future<void> save(String sessionId, List<MessageModel> messages) => _prefs.setString(_key(sessionId), jsonEncode(messages.take(200).map((m) => m.toJson()).toList()));
  List<MessageModel> load(String sessionId) { final r = _prefs.getString(_key(sessionId)); if (r == null) return []; try { return (jsonDecode(r) as List).map((e) => MessageModel.fromJson(e)).toList(); } catch (_) { return []; } }
  Future<void> clear(String sessionId) => _prefs.remove(_key(sessionId));
}
