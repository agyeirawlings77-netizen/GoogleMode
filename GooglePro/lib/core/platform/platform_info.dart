import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class PlatformInfo {
  AndroidDeviceInfo? _androidInfo;
  PackageInfo? _packageInfo;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      _androidInfo = await DeviceInfoPlugin().androidInfo;
      _packageInfo = await PackageInfo.fromPlatform();
      _initialized = true;
      AppLogger.info('PlatformInfo initialized: ${deviceName}');
    } catch (e) { AppLogger.warning('PlatformInfo init failed: $e'); }
  }

  String get deviceName => _androidInfo != null ? '${_androidInfo!.manufacturer} ${_androidInfo!.model}' : 'Android Device';
  String get manufacturer => _androidInfo?.manufacturer ?? 'Unknown';
  String get model => _androidInfo?.model ?? 'Unknown';
  String get androidVersion => _androidInfo?.version.release ?? 'Unknown';
  int get sdkInt => _androidInfo?.version.sdkInt ?? 0;
  String get appVersion => _packageInfo?.version ?? '1.0.0';
  String get buildNumber => _packageInfo?.buildNumber ?? '1';
  String get packageName => _packageInfo?.packageName ?? 'com.rawlings.GooglePro';
  bool get isHighEnd => sdkInt >= 29;
  bool get supportsMediaProjection => sdkInt >= 21;
  bool get supportsBiometric => sdkInt >= 23;
  bool get supportsNotificationPermission => sdkInt >= 33;
}
