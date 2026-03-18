import 'package:battery_plus/battery_plus.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class BatteryService {
  final Battery _battery = Battery();
  int _level = 100;
  bool _isCharging = false;

  int get level => _level;
  bool get isCharging => _isCharging;
  bool get isLow => _level <= 15;

  Future<void> initialize() async {
    try {
      _level = await _battery.batteryLevel;
      final state = await _battery.batteryState;
      _isCharging = state == BatteryState.charging || state == BatteryState.full;
      _battery.onBatteryStateChanged.listen((state) {
        _isCharging = state == BatteryState.charging || state == BatteryState.full;
        AppLogger.debug('Battery state: $state, charging: $_isCharging');
      });
      AppLogger.info('Battery: $_level% charging=$_isCharging');
    } catch (e) { AppLogger.warning('Battery service failed: $e'); }
  }

  Future<int> getBatteryLevel() async {
    try { _level = await _battery.batteryLevel; return _level; }
    catch (e) { return _level; }
  }

  Stream<BatteryState> get stateStream => _battery.onBatteryStateChanged;
}
