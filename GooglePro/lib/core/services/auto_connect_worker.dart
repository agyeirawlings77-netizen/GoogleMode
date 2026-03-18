import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';
import 'trusted_device_manager.dart';

class AutoConnectWorker {
  static const String taskName = AppConstants.wmAutoConnect;
  static const String uniqueName = AppConstants.wmAutoConnectUnique;

  static Future<bool> execute(Map<String, dynamic> inputData) async {
    AppLogger.info('AutoConnectWorker: Starting...');
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) { AppLogger.info('Not logged in'); return true; }
      final manager = TrustedDeviceManager(const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ));
      final devices = await manager.getAllTrustedDevices();
      if (devices.isEmpty) return true;
      for (final device in devices) {
        if (!device.autoConnect) continue;
        try {
          final snap = await FirebaseDatabase.instance
              .ref('${AppConstants.presencePath}/${device.ownerUserId}/${device.deviceId}')
              .get();
          if (snap.exists) {
            final data = snap.value as Map<dynamic, dynamic>?;
            final online = data?['online'] as bool? ?? false;
            if (online) {
              await manager.updateLastConnected(device.deviceId);
              await FirebaseDatabase.instance
                  .ref('${AppConstants.autoConnectSignalsPath}/${user.uid}/${device.deviceId}')
                  .set({'pending': true, 'timestamp': ServerValue.timestamp});
            }
          }
        } catch (e) { AppLogger.warning('Check failed for ${device.deviceName}: $e'); }
      }
      return true;
    } catch (e, s) { AppLogger.error('AutoConnectWorker fatal', e, s); return false; }
  }
}
