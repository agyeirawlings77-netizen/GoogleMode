import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class MethodChannelService {
  static const _channel = MethodChannel('com.rawlings.googlepro/methods');
  static const _eventChannel = EventChannel('com.rawlings.googlepro/events');

  /// Open manufacturer auto-start settings (Xiaomi, Samsung, etc.)
  Future<bool> openAutoStartSettings() async {
    try { return await _channel.invokeMethod<bool>('openAutoStartSettings') ?? false; }
    catch (e) { AppLogger.warning('openAutoStartSettings: $e'); return false; }
  }

  /// Get Android device manufacturer string
  Future<String> getManufacturer() async {
    try { return await _channel.invokeMethod<String>('getManufacturer') ?? 'Unknown'; }
    catch (e) { return 'Unknown'; }
  }

  /// Get full device model name
  Future<String> getDeviceModel() async {
    try { return await _channel.invokeMethod<String>('getDeviceModel') ?? 'Android Device'; }
    catch (e) { return 'Android Device'; }
  }

  /// Get current battery level (0-100)
  Future<int> getBatteryLevel() async {
    try { return await _channel.invokeMethod<int>('getBatteryLevel') ?? -1; }
    catch (e) { return -1; }
  }

  /// Get current network type: 'wifi', 'mobile', 'ethernet', 'none'
  Future<String> getNetworkType() async {
    try { return await _channel.invokeMethod<String>('getNetworkType') ?? 'unknown'; }
    catch (e) { return 'unknown'; }
  }

  /// Listen to events sent from Android → Flutter
  Stream<dynamic> get eventStream => _eventChannel.receiveBroadcastStream();

  Future<void> invokeMethod(String method, [dynamic arguments]) async {
    try { await _channel.invokeMethod(method, arguments); }
    catch (e) { AppLogger.warning('MethodChannel $method failed: $e'); }
  }
}
