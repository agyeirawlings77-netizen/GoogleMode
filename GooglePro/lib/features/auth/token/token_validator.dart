import 'package:firebase_auth/firebase_auth.dart';

class TokenValidator {
  static bool isFirebaseUserValid(User? user) {
    if (user == null) return false;
    return true;
  }
  static Future<bool> isTokenFresh() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      await user.getIdToken(false);
      return true;
    } catch (_) { return false; }
  }
}
