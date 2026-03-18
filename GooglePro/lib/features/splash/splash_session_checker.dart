import 'package:firebase_auth/firebase_auth.dart';
import '../../core/app/app_session_manager.dart';
import '../../core/di/injection.dart';

class SplashSessionChecker {
  static Future<bool> isSessionValid() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    try {
      final mgr = getIt<AppSessionManager>();
      return mgr.isSessionActive();
    } catch (_) { return user != null; }
  }
}
