import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_logger.dart';

@singleton
class FirebasePresenceService {
  final _db = FirebaseDatabase.instance;

  Future<void> setOnline(String? deviceId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final path = '${AppConstants.presencePath}/$uid${deviceId != null ? "/$deviceId" : "/self"}';
    final ref = _db.ref(path);
    await ref.update({'online': true, 'lastSeen': ServerValue.timestamp});
    await ref.onDisconnect().update({'online': false, 'lastSeen': ServerValue.timestamp});
    AppLogger.debug('Presence: online at $path');
  }

  Future<void> setOffline(String? deviceId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final path = '${AppConstants.presencePath}/$uid${deviceId != null ? "/$deviceId" : "/self"}';
    await _db.ref(path).update({'online': false, 'lastSeen': ServerValue.timestamp});
  }

  Stream<bool> watchPresence(String uid, {String? deviceId}) {
    final path = '${AppConstants.presencePath}/$uid${deviceId != null ? "/$deviceId" : "/self"}/online';
    return _db.ref(path).onValue.map((e) => e.snapshot.value as bool? ?? false);
  }

  Future<bool> isOnline(String uid, {String? deviceId}) async {
    final path = '${AppConstants.presencePath}/$uid${deviceId != null ? "/$deviceId" : "/self"}/online';
    final snap = await _db.ref(path).get();
    return snap.value as bool? ?? false;
  }
}
