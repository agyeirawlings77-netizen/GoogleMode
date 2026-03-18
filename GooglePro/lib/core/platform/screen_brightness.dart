import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class ScreenBrightness {
  double _brightness = 0.5;
  bool _keepOn = false;

  double get current => _brightness;
  bool get keepOn => _keepOn;

  Future<void> setKeepScreenOn(bool on) async {
    _keepOn = on;
    AppLogger.debug('Keep screen on: $on');
  }

  Future<void> setBrightness(double value) async {
    _brightness = value.clamp(0.0, 1.0);
    AppLogger.debug('Screen brightness: $_brightness');
  }

  Future<void> resetBrightness() => setBrightness(0.5);
}
