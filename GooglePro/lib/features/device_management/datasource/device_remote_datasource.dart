import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../model/device_model_local.dart';
@singleton
class DeviceRemoteDatasource {
  final FirebaseFirestore _db;
  DeviceRemoteDatasource(this._db);
  Future<List<DeviceModelLocal>> getAll(String uid) async {
    final snap = await _db.collection('devices').where('ownerUserId', isEqualTo: uid).get();
    return snap.docs.map((d) => DeviceModelLocal.fromJson({...d.data(), 'deviceId': d.id})).toList();
  }
  Stream<List<DeviceModelLocal>> watchAll(String uid) => _db.collection('devices').where('ownerUserId', isEqualTo: uid).snapshots().map((s) => s.docs.map((d) => DeviceModelLocal.fromJson({...d.data(), 'deviceId': d.id})).toList());
  Future<void> update(String id, Map<String, dynamic> data) => _db.collection('devices').doc(id).update(data);
  Future<void> delete(String id) => _db.collection('devices').doc(id).delete();
  Future<void> set(String id, Map<String, dynamic> data) => _db.collection('devices').doc(id).set(data, SetOptions(merge: true));
}
