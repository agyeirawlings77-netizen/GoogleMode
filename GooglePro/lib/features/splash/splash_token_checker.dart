import 'package:firebase_auth/firebase_auth.dart';

class SplashTokenChecker {
  static Future<bool> hasValidToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      final token = await user.getIdToken(false);
      return token != null && token.isNotEmpty;
    } catch (_) { return false; }
  }
}
