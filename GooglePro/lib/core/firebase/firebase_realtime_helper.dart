import 'package:firebase_database/firebase_database.dart';
import '../utils/app_logger.dart';

class FirebaseRealtimeHelper {
  static Future<void> set(String path, dynamic value) async { try { await FirebaseDatabase.instance.ref(path).set(value); } catch (e) { AppLogger.error('RTDB set: $path', e); rethrow; } }
  static Future<void> update(String path, Map<String, dynamic> data) async { try { await FirebaseDatabase.instance.ref(path).update(data); } catch (e) { AppLogger.error('RTDB update: $path', e); rethrow; } }
  static Future<DataSnapshot> get(String path) async { try { return await FirebaseDatabase.instance.ref(path).get(); } catch (e) { AppLogger.error('RTDB get: $path', e); rethrow; } }
  static Future<void> delete(String path) async { try { await FirebaseDatabase.instance.ref(path).remove(); } catch (e) { AppLogger.error('RTDB delete: $path', e); rethrow; } }
  static Future<String> push(String path, Map<String, dynamic> data) async { final r = FirebaseDatabase.instance.ref(path).push(); await r.set(data); return r.key!; }
  static Stream<DatabaseEvent> watch(String path) => FirebaseDatabase.instance.ref(path).onValue;
  static Stream<DatabaseEvent> watchChild(String path) => FirebaseDatabase.instance.ref(path).onChildAdded;
}
