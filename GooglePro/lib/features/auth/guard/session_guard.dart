import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class SessionGuard {
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;
  String? get currentUserEmail => FirebaseAuth.instance.currentUser?.email;
  bool get isEmailVerified => FirebaseAuth.instance.currentUser?.emailVerified ?? false;

  Future<bool> validateSession() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      await user.reload();
      return FirebaseAuth.instance.currentUser != null;
    } catch (_) { return false; }
  }
}
