import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/trusted_device_manager.dart';
import '../../core/di/injection.dart';
import '../../core/utils/app_logger.dart';

class SplashAutoConnectChecker {
  static Future<List<String>> getOnlineTrustedDevices() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    final mgr = getIt<TrustedDeviceManager>();
    final trusted = await mgr.getAllTrustedDevices();
    final online = <String>[];
    for (final device in trusted) {
      if (!device.autoConnect) continue;
      try {
        final snap = await FirebaseDatabase.instance
            .ref('${AppConstants.presencePath}/${device.ownerUserId}/${device.deviceId}')
            .get();
        if (snap.exists) {
          final data = snap.value as Map<dynamic, dynamic>?;
          if (data?['online'] == true) online.add(device.deviceId);
        }
      } catch (e) { AppLogger.warning('Splash check failed for ${device.deviceId}: $e'); }
    }
    return online;
  }
}
