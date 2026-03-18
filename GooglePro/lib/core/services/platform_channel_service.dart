import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class PlatformChannelService {
  static const _channel = MethodChannel('com.rawlings.googlepro/native');

  Future<bool> openAutoStartSettings() async {
    try { return await _channel.invokeMethod<bool>('openAutoStartSettings') ?? false; }
    catch (e) { AppLogger.error('openAutoStartSettings failed', e); return false; }
  }

  Future<String> getManufacturer() async {
    try { return await _channel.invokeMethod<String>('getManufacturer') ?? 'Unknown'; }
    catch (_) { return 'Unknown'; }
  }

  Future<String> getDeviceModel() async {
    try { return await _channel.invokeMethod<String>('getDeviceModel') ?? 'Unknown Device'; }
    catch (_) { return 'Unknown Device'; }
  }

  Future<bool> isServiceRunning() async {
    try { return await _channel.invokeMethod<bool>('isServiceRunning') ?? false; }
    catch (_) { return false; }
  }
}
