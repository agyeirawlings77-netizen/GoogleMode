import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

@singleton
class DevicePresenceService {
  final _db = FirebaseDatabase.instance;
  Timer? _heartbeat;
  String? _deviceId;

  Future<void> startPresence({required String deviceId}) async {
    _deviceId = deviceId;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await _setPresence(uid, deviceId, true);
    _heartbeat = Timer.periodic(const Duration(seconds: AppConstants.heartbeatIntervalSeconds), (_) => _setPresence(uid, deviceId, true));
    AppLogger.info('Presence started: $deviceId');
  }

  Future<void> stopPresence() async {
    _heartbeat?.cancel();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null && _deviceId != null) await _setPresence(uid, _deviceId!, false);
    _deviceId = null;
    AppLogger.info('Presence stopped');
  }

  Future<void> _setPresence(String uid, String deviceId, bool online) async {
    final ref = _db.ref('${AppConstants.presencePath}/$uid/$deviceId');
    await ref.update({'online': online, 'lastSeen': ServerValue.timestamp});
    if (online) await ref.onDisconnect().update({'online': false, 'lastSeen': ServerValue.timestamp});
  }

  Stream<bool> watchDevicePresence(String ownerUid, String deviceId) => _db.ref('${AppConstants.presencePath}/$ownerUid/$deviceId/online').onValue.map((e) => e.snapshot.value as bool? ?? false);

  Future<bool> isDeviceOnline(String ownerUid, String deviceId) async {
    final snap = await _db.ref('${AppConstants.presencePath}/$ownerUid/$deviceId/online').get();
    return snap.value as bool? ?? false;
  }

  void dispose() { _heartbeat?.cancel(); }
}
