import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';
import '../utils/app_logger.dart';

@singleton
class VibrationService {
  Future<bool> get canVibrate async => await Vibration.hasVibrator() ?? false;

  Future<void> vibrate({int duration = 100, int amplitude = -1}) async {
    try {
      if (await canVibrate) Vibration.vibrate(duration: duration, amplitude: amplitude);
    } catch (e) { AppLogger.debug('Vibration failed: $e'); }
  }

  Future<void> pattern(List<int> pattern) async {
    try { if (await canVibrate) Vibration.vibrate(pattern: pattern); }
    catch (e) { AppLogger.debug('Vibration pattern failed: $e'); }
  }

  Future<void> success() => pattern([0, 50, 50, 50]);
  Future<void> error() => pattern([0, 100, 50, 100, 50, 100]);
  Future<void> tap() => vibrate(duration: 30);
  Future<void> cancel() => Future(() => Vibration.cancel());
}
