import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class TokenRefresher {
  Future<String?> refresh() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      final token = await user.getIdToken(true);
      AppLogger.info('Token refreshed');
      return token;
    } catch (e) { AppLogger.error('Token refresh failed', e); return null; }
  }
}
