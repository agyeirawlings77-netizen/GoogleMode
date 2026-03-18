import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../model/auth_user.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthService(this._auth, this._firestore);

  Future<AuthUser> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = AuthUser.fromFirebase(cred.user!);
    await _save(user);
    AppLogger.info('Signed in: ${user.email}');
    return user;
  }

  Future<AuthUser> register({required String name, required String email, required String password}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await cred.user?.updateDisplayName(name);
    await cred.user?.reload();
    final user = AuthUser.fromFirebase(_auth.currentUser!).copyWith(displayName: name);
    await _save(user);
    AppLogger.info('Registered: ${user.email}');
    return user;
  }

  Future<void> sendPasswordReset(String email) => _auth.sendPasswordResetEmail(email: email);

  Future<void> signOut() => _auth.signOut();

  Future<void> sendPhoneOtp(String phone, void Function(String, int?) codeSent, void Function(FirebaseAuthException) failed) =>
    _auth.verifyPhoneNumber(phoneNumber: phone, codeSent: codeSent, verificationFailed: failed, codeAutoRetrievalTimeout: (_) {}, timeout: const Duration(seconds: 60));

  Future<AuthUser> verifyOtp(String verificationId, String otp) async {
    final cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    final result = await _auth.signInWithCredential(cred);
    return AuthUser.fromFirebase(result.user!);
  }

  AuthUser? getCurrentUser() { final u = _auth.currentUser; return u != null ? AuthUser.fromFirebase(u) : null; }
  Stream<AuthUser?> get authStateChanges => _auth.authStateChanges().map((u) => u != null ? AuthUser.fromFirebase(u) : null);

  Future<void> updateFcmToken(String uid, String token) =>
    _firestore.collection('users').doc(uid).update({'fcmToken': token, 'lastSeen': FieldValue.serverTimestamp()});

  Future<void> _save(AuthUser u) =>
    _firestore.collection('users').doc(u.uid).set(u.toJson(), SetOptions(merge: true));
}
