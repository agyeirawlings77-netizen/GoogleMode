import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class RemoteConfigService {
  final FirebaseRemoteConfig _config;
  RemoteConfigService(this._config);

  Future<void> initialize() async {
    try {
      await _config.setConfigSettings(RemoteConfigSettings(fetchTimeout: const Duration(seconds: 10), minimumFetchInterval: const Duration(hours: 1)));
      await _config.setDefaults({'max_bitrate_kbps': '8000', 'default_fps': '15', 'enable_ai_assistant': 'true', 'max_file_size_mb': '2048', 'signaling_url': 'wss://googlepro-signaling.onrender.com/ws'});
      await _config.fetchAndActivate();
      AppLogger.info('Remote config loaded');
    } catch (e) { AppLogger.warning('Remote config failed: $e'); }
  }

  int getInt(String key) => _config.getInt(key);
  String getString(String key) => _config.getString(key);
  bool getBool(String key) => _config.getBool(key);
  double getDouble(String key) => _config.getDouble(key);
}
