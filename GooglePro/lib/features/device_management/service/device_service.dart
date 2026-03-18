import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';
import '../model/device_model_local.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class DeviceService {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _rtdb;
  DeviceService(this._firestore, this._rtdb);

  Future<List<DeviceModelLocal>> getDevices(String uid) async {
    final snap = await _firestore.collection('devices').where('ownerUserId', isEqualTo: uid).get();
    return snap.docs.map((d) => DeviceModelLocal.fromJson({...d.data(), 'deviceId': d.id})).toList();
  }

  Stream<List<DeviceModelLocal>> watchDevices(String uid) =>
    _firestore.collection('devices').where('ownerUserId', isEqualTo: uid).snapshots()
      .map((s) => s.docs.map((d) => DeviceModelLocal.fromJson({...d.data(), 'deviceId': d.id})).toList());

  Future<DeviceModelLocal> registerThisDevice() async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final info = await DeviceInfoPlugin().androidInfo;
    final pkg = await PackageInfo.fromPlatform();
    final device = DeviceModelLocal(deviceId: const Uuid().v4(), deviceName: '${info.manufacturer} ${info.model}', type: DeviceTypeLocal.phone, ownerUserId: uid, osVersion: info.version.release, appVersion: pkg.version);
    await _firestore.collection('devices').doc(device.deviceId).set(device.toJson());
    AppLogger.info('Device registered: ${device.deviceName}');
    return device;
  }

  Future<void> renameDevice(String deviceId, String name) =>
    _firestore.collection('devices').doc(deviceId).update({'deviceName': name});

  Future<void> deleteDevice(String deviceId) =>
    _firestore.collection('devices').doc(deviceId).delete();

  Future<void> updateFcmToken(String deviceId, String token) =>
    _firestore.collection('devices').doc(deviceId).update({'fcmToken': token});

  Future<void> setPresence(String uid, String deviceId, bool online) async {
    final ref = _rtdb.ref('${AppConstants.presencePath}/$uid/$deviceId');
    await ref.update({'online': online, 'ts': ServerValue.timestamp});
    if (online) await ref.onDisconnect().update({'online': false, 'ts': ServerValue.timestamp});
  }

  Stream<bool> watchPresence(String uid, String deviceId) =>
    _rtdb.ref('${AppConstants.presencePath}/$uid/$deviceId/online').onValue.map((e) => e.snapshot.value as bool? ?? false);
}
