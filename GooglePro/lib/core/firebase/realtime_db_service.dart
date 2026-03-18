import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class RealtimeDbService {
  final FirebaseDatabase _db;
  RealtimeDbService(this._db);

  DatabaseReference ref(String path) => _db.ref(path);

  Future<void> set(String path, dynamic value) async {
    await _db.ref(path).set(value);
    AppLogger.debug('RTDB SET: $path');
  }

  Future<void> update(String path, Map<String, dynamic> data) => _db.ref(path).update(data);

  Future<void> push(String path, dynamic value) => _db.ref(path).push().set(value);

  Future<void> remove(String path) => _db.ref(path).remove();

  Future<DataSnapshot> get(String path) async {
    final snap = await _db.ref(path).get();
    AppLogger.debug('RTDB GET: $path exists=${snap.exists}');
    return snap;
  }

  Stream<DatabaseEvent> watch(String path) => _db.ref(path).onValue;
  Stream<DatabaseEvent> watchChildAdded(String path) => _db.ref(path).onChildAdded;
  Stream<DatabaseEvent> watchChildChanged(String path) => _db.ref(path).onChildChanged;
  Stream<DatabaseEvent> watchChildRemoved(String path) => _db.ref(path).onChildRemoved;

  Future<void> setOnDisconnect(String path, dynamic value) => _db.ref(path).onDisconnect().set(value);
  Future<void> updateOnDisconnect(String path, Map<String, dynamic> data) => _db.ref(path).onDisconnect().update(data);
  Future<void> removeOnDisconnect(String path) => _db.ref(path).onDisconnect().remove();

  Future<void> withPresence(String path, dynamic onlineValue, dynamic offlineValue) async {
    final ref = _db.ref(path);
    await ref.set(onlineValue);
    await ref.onDisconnect().set(offlineValue);
  }
}
