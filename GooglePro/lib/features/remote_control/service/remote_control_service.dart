import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../model/input_event.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class RemoteControlService {
  final _db = FirebaseDatabase.instance;
  bool _enabled = false;
  bool get isEnabled => _enabled;

  Future<void> sendInputEvent(String targetDeviceId, InputEvent event) async {
    if (!_enabled) return;
    await _db.ref('remote_input/$targetDeviceId').push().set(event.toJson());
    AppLogger.debug('Input sent: ${event.type.name} (${event.x?.toStringAsFixed(0)}, ${event.y?.toStringAsFixed(0)})');
  }

  Stream<InputEvent> watchInputEvents(String deviceId) => _db.ref('remote_input/$deviceId').onChildAdded.map((e) {
    if (!e.snapshot.exists) return InputEvent.tap(0, 0);
    return InputEvent.fromJson(Map<String, dynamic>.from(e.snapshot.value as Map));
  });

  Future<void> clearInputQueue(String deviceId) => _db.ref('remote_input/$deviceId').remove();

  void enable() { _enabled = true; AppLogger.info('Remote control enabled'); }
  void disable() { _enabled = false; AppLogger.info('Remote control disabled'); }

  Future<void> sendTap(String deviceId, double x, double y) => sendInputEvent(deviceId, InputEvent.tap(x, y));
  Future<void> sendSwipe(String deviceId, double x1, double y1, double x2, double y2) => sendInputEvent(deviceId, InputEvent.swipe(x1, y1, x2, y2));
  Future<void> sendText(String deviceId, String text) => sendInputEvent(deviceId, InputEvent.typeText(text));
  Future<void> sendBack(String deviceId) => sendInputEvent(deviceId, InputEvent(type: InputEventType.back, timestamp: DateTime.now().millisecondsSinceEpoch));
  Future<void> sendHome(String deviceId) => sendInputEvent(deviceId, InputEvent(type: InputEventType.home, timestamp: DateTime.now().millisecondsSinceEpoch));
}
