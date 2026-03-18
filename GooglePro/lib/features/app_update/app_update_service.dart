import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/utils/app_logger.dart';

@injectable
class AppUpdateService {
  static const _latestVersion = '1.0.0';

  Future<bool> isUpdateAvailable() async {
    try {
      final pkg = await PackageInfo.fromPlatform();
      final current = pkg.version;
      // In production: compare against remote config or Play Store
      AppLogger.info('App version check: $current vs $_latestVersion');
      return _isNewerVersion(_latestVersion, current);
    } catch (e) { AppLogger.warning('Version check failed: $e'); return false; }
  }

  bool _isNewerVersion(String remote, String current) {
    final r = remote.split('.').map(int.parse).toList();
    final c = current.split('.').map(int.parse).toList();
    for (var i = 0; i < 3; i++) {
      if ((r[i]) > (c[i])) return true;
      if ((r[i]) < (c[i])) return false;
    }
    return false;
  }

  Future<void> openPlayStore(String packageName) async {
    AppLogger.info('Opening Play Store for $packageName');
    // In production: use url_launcher to open Play Store URL
  }
}
