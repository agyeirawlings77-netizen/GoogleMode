import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class NativeChannelService {
  static const _ch = MethodChannel('com.rawlings.googlepro/native');

  Future<bool> openAutoStartSettings() async { try { return await _ch.invokeMethod<bool>('openAutoStartSettings') ?? false; } catch (e) { AppLogger.warning('autoStart: $e'); return false; } }
  Future<String> getManufacturer() async { try { return await _ch.invokeMethod<String>('getManufacturer') ?? 'Unknown'; } catch (_) { return 'Unknown'; } }
  Future<String> getDeviceName() async { try { return await _ch.invokeMethod<String>('getDeviceName') ?? 'Android Device'; } catch (_) { return 'Android Device'; } }
  Future<bool> needsAutoStart() async { try { return await _ch.invokeMethod<bool>('needsAutoStart') ?? false; } catch (_) { return false; } }
  Future<int> getBatteryLevel() async { try { return await _ch.invokeMethod<int>('getBatteryLevel') ?? -1; } catch (_) { return -1; } }
  Future<bool> requestBatteryOptimization() async { try { return await _ch.invokeMethod<bool>('requestBatteryOptimization') ?? false; } catch (_) { return false; } }
  Future<bool> isIgnoringBatteryOptimizations() async { try { return await _ch.invokeMethod<bool>('isIgnoringBatteryOptimizations') ?? false; } catch (_) { return false; } }
  Future<bool> startForegroundService() async { try { return await _ch.invokeMethod<bool>('startForegroundService') ?? false; } catch (e) { AppLogger.error('FG service start', e); return false; } }
  Future<bool> stopForegroundService() async { try { return await _ch.invokeMethod<bool>('stopForegroundService') ?? false; } catch (_) { return false; } }
  Future<bool> updateServiceNotification(String title, String text) async { try { return await _ch.invokeMethod<bool>('updateServiceNotification', {'title': title, 'text': text}) ?? false; } catch (_) { return false; } }
  Future<int> getAndroidVersion() async { try { return await _ch.invokeMethod<int>('getAndroidVersion') ?? 0; } catch (_) { return 0; } }
  Future<bool> scheduleAutoConnect() async { try { return await _ch.invokeMethod<bool>('scheduleAutoConnect') ?? false; } catch (_) { return false; } }
}
