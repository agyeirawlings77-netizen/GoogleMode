import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

class FirebaseConfig {
  static Future<void> init() async {
    final rc = FirebaseRemoteConfig.instance;
    await rc.setConfigSettings(RemoteConfigSettings(fetchTimeout: const Duration(seconds: 10), minimumFetchInterval: const Duration(hours: 1)));
    await rc.setDefaults({'signaling_url': AppConstants.signalingWsUrl, 'max_bitrate_kbps': 8000, 'default_fps': 15, 'ai_enabled': true});
    try { await rc.fetchAndActivate(); AppLogger.info('Remote config fetched'); }
    catch (e) { AppLogger.warning('Remote config fallback: $e'); }
  }
  static bool get maintenanceMode => FirebaseRemoteConfig.instance.getBool('maintenance_mode');
  static String get signalingUrl { final v = FirebaseRemoteConfig.instance.getString('signaling_url'); return v.isNotEmpty ? v : AppConstants.signalingWsUrl; }
  static int get defaultFps => FirebaseRemoteConfig.instance.getInt('default_fps');
  static bool get aiEnabled => FirebaseRemoteConfig.instance.getBool('ai_enabled');
}
