import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../model/auth_user.dart';
import '../model/register_request.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRemoteDataSource(this._auth, this._firestore);

  Future<UserCredential> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> registerWithEmail(RegisterRequest req) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: req.email, password: req.password);
    await cred.user?.updateDisplayName(req.name);
    await _saveUserToFirestore(cred.user!, req.name, req.phone);
    return cred;
  }

  Future<void> _saveUserToFirestore(User user, String name, String? phone) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid, 'email': user.email, 'displayName': name,
      'phone': phone, 'createdAt': FieldValue.serverTimestamp(),
      'isOnline': true, 'fcmToken': null,
    }, SetOptions(merge: true));
  }

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> signOut() => _auth.signOut();

  Future<void> verifyPhoneNumber({
    required String phone,
    required Function(PhoneAuthCredential) onVerified,
    required Function(FirebaseAuthException) onFailed,
    required Function(String, int?) onCodeSent,
    required Function(String) onTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: onVerified,
      verificationFailed: onFailed,
      codeSent: (id, resend) => onCodeSent(id, resend),
      codeAutoRetrievalTimeout: onTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<UserCredential> signInWithOtp(String verificationId, String otp) {
    final cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    return _auth.signInWithCredential(cred);
  }

  AuthUser? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUser(uid: user.uid, email: user.email ?? '', displayName: user.displayName,
        photoUrl: user.photoURL, emailVerified: user.emailVerified, phone: user.phoneNumber);
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> updateFcmToken(String uid, String token) async {
    try {
      await _firestore.collection('users').doc(uid).update({'fcmToken': token});
    } catch (e) { AppLogger.warning('FCM token update failed: $e'); }
  }
}
