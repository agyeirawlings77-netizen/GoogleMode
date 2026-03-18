import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../utils/app_logger.dart';

@singleton
class WakelockService {
  bool _enabled = false;
  bool get isEnabled => _enabled;

  Future<void> enable() async {
    try { await WakelockPlus.enable(); _enabled = true; AppLogger.debug('Wakelock enabled'); }
    catch (e) { AppLogger.warning('Wakelock enable failed: $e'); }
  }

  Future<void> disable() async {
    try { await WakelockPlus.disable(); _enabled = false; AppLogger.debug('Wakelock disabled'); }
    catch (e) { AppLogger.warning('Wakelock disable failed: $e'); }
  }

  Future<void> toggle(bool enable) => enable ? this.enable() : disable();
}
