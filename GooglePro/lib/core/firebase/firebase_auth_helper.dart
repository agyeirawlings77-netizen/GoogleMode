import 'package:firebase_auth/firebase_auth.dart';
import '../utils/app_logger.dart';

class FirebaseAuthHelper {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;
  static String? get currentUid => _auth.currentUser?.uid;
  static String? get currentEmail => _auth.currentUser?.email;
  static String? get displayName => _auth.currentUser?.displayName;
  static bool get isSignedIn => _auth.currentUser != null;

  static Future<String?> getIdToken({bool forceRefresh = false}) async {
    try { return await _auth.currentUser?.getIdToken(forceRefresh); }
    catch (e) { AppLogger.error('Get ID token failed', e); return null; }
  }

  static Future<bool> reloadUser() async {
    try { await _auth.currentUser?.reload(); return true; }
    catch (e) { AppLogger.warning('Reload user failed: $e'); return false; }
  }

  static Stream<User?> get authStateChanges => _auth.authStateChanges();
  static Stream<User?> get userChanges => _auth.userChanges();
}
