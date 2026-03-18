import '../../core/services/trusted_device_manager.dart';
import '../../core/di/injection.dart';
import '../trusted_device/model/trusted_device_model.dart';

class SplashTrustedDeviceLoader {
  static Future<List<TrustedDeviceModel>> load() async {
    try {
      return getIt<TrustedDeviceManager>().getAllTrustedDevices();
    } catch (_) { return []; }
  }
}
