import 'package:firebase_auth/firebase_auth.dart';
import '../../core/services/trusted_device_manager.dart';
import '../../core/di/injection.dart';

class SplashRouteDecider {
  static Future<String> decide() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return '/login';
    try {
      final mgr = getIt<TrustedDeviceManager>();
      final devices = await mgr.getAllTrustedDevices();
      if (devices.isNotEmpty) return '/dashboard';
    } catch (_) {}
    return '/dashboard';
  }
}
