import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../models/user_model.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class UserRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UserRemoteDatasource(this._firestore, this._auth);

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson(), SetOptions(merge: true));
    AppLogger.info('User created: ${user.uid}');
  }

  Future<UserModel?> getUser(String uid) async {
    final snap = await _firestore.collection('users').doc(uid).get();
    if (!snap.exists) return null;
    return UserModel.fromJson({...snap.data()!, 'uid': snap.id});
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update({...data, 'updatedAt': FieldValue.serverTimestamp()});
  }

  Future<void> updateFcmToken(String uid, String token) async {
    await _firestore.collection('users').doc(uid).update({'fcmToken': token, 'lastSeen': FieldValue.serverTimestamp()});
  }

  Future<void> setOnlineStatus(String uid, bool online) async {
    await _firestore.collection('users').doc(uid).update({'isOnline': online, 'lastSeen': FieldValue.serverTimestamp()});
  }

  Stream<UserModel?> watchUser(String uid) => _firestore.collection('users').doc(uid).snapshots()
    .map((s) => s.exists ? UserModel.fromJson({...s.data()!, 'uid': s.id}) : null);

  Future<void> deleteUser(String uid) => _firestore.collection('users').doc(uid).delete();
}
