import 'package:firebase_database/firebase_database.dart';
import '../utils/app_logger.dart';

class RealtimeDbHelper {
  static final _db = FirebaseDatabase.instance;

  static Future<T?> safeGet<T>(String path, T Function(dynamic) mapper) async {
    try {
      final snap = await _db.ref(path).get();
      if (!snap.exists) return null;
      return mapper(snap.value);
    } catch (e, s) { AppLogger.error('RTDB get error at $path', e, s); return null; }
  }

  static Future<bool> safeSet(String path, dynamic data) async {
    try { await _db.ref(path).set(data); return true; }
    catch (e, s) { AppLogger.error('RTDB set error at $path', e, s); return false; }
  }

  static Future<bool> safeUpdate(String path, Map<String, dynamic> data) async {
    try { await _db.ref(path).update(data); return true; }
    catch (e, s) { AppLogger.error('RTDB update error at $path', e, s); return false; }
  }

  static Future<bool> safeDelete(String path) async {
    try { await _db.ref(path).remove(); return true; }
    catch (e, s) { AppLogger.error('RTDB delete error at $path', e, s); return false; }
  }

  static Stream<T?> watch<T>(String path, T Function(dynamic) mapper) =>
    _db.ref(path).onValue.map((e) => e.snapshot.exists ? mapper(e.snapshot.value) : null);

  static Future<void> setPresenceWithDisconnect(String path, Map<String, dynamic> onlineData, Map<String, dynamic> offlineData) async {
    final ref = _db.ref(path);
    await ref.update(onlineData);
    await ref.onDisconnect().update(offlineData);
  }
}
