import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService(this._auth);

  User? get currentUser => _auth.currentUser;
  String? get currentUid => _auth.currentUser?.uid;
  bool get isSignedIn => _auth.currentUser != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmail(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);
  Future<UserCredential> registerWithEmail(String email, String password) => _auth.createUserWithEmailAndPassword(email: email, password: password);
  Future<void> sendPasswordResetEmail(String email) => _auth.sendPasswordResetEmail(email: email);
  Future<void> signOut() async { await _auth.signOut(); AppLogger.info('Signed out'); }
  Future<void> updateDisplayName(String name) async { await _auth.currentUser?.updateDisplayName(name); }
  Future<void> updatePhotoUrl(String url) async { await _auth.currentUser?.updatePhotoURL(url); }
  Future<String?> getIdToken({bool forceRefresh = false}) => _auth.currentUser?.getIdToken(forceRefresh);
  Future<void> deleteAccount() => _auth.currentUser?.delete() ?? Future.value();
  Future<void> reloadUser() => _auth.currentUser?.reload() ?? Future.value();
}
