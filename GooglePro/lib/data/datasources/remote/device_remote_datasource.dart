import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../models/device_model.dart';
import '../../../core/constants/app_constants.dart';

@singleton
class DeviceRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _rtdb;
  DeviceRemoteDatasource(this._firestore, this._rtdb);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<List<DeviceModel>> getDevices() async {
    final snap = await _firestore.collection('devices').where('ownerUserId', isEqualTo: _uid).get();
    return snap.docs.map((d) => DeviceModel.fromJson({...d.data(), 'deviceId': d.id})).toList();
  }

  Future<void> registerDevice(DeviceModel device) => _firestore.collection('devices').doc(device.deviceId).set(device.toJson(), SetOptions(merge: true));

  Future<void> updateDevice(String deviceId, Map<String, dynamic> data) => _firestore.collection('devices').doc(deviceId).update(data);

  Future<void> deleteDevice(String deviceId) => _firestore.collection('devices').doc(deviceId).delete();

  Stream<List<DeviceModel>> watchDevices() => _firestore.collection('devices').where('ownerUserId', isEqualTo: _uid).snapshots()
    .map((s) => s.docs.map((d) => DeviceModel.fromJson({...d.data(), 'deviceId': d.id})).toList());

  Future<void> setPresence(String uid, String deviceId, bool online) => _rtdb.ref('${AppConstants.presencePath}/$uid/$deviceId').update({'online': online, 'lastSeen': ServerValue.timestamp});

  Stream<bool> watchPresence(String uid, String deviceId) => _rtdb.ref('${AppConstants.presencePath}/$uid/$deviceId/online').onValue.map((e) => e.snapshot.value as bool? ?? false);
}
