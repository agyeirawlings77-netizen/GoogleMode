import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../model/app_settings.dart';
@singleton
class SettingsRemoteDatasource {
  final FirebaseFirestore _firestore;
  SettingsRemoteDatasource(this._firestore);
  Future<void> sync(AppSettings s) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('user_settings').doc(uid).set(s.toJson(), SetOptions(merge: true));
  }
  Future<AppSettings?> load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    final snap = await _firestore.collection('user_settings').doc(uid).get();
    if (!snap.exists) return null;
    try { return AppSettings.fromJson(snap.data()!); } catch (_) { return null; }
  }
}
