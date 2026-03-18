import '../model/remote_command.dart';
import '../model/touch_event_model.dart';
abstract class RemoteControlRepository {
  Future<void> sendTouch(String deviceId, TouchEventModel event);
  Future<void> sendCommand(String deviceId, RemoteCommand command);
  Stream<RemoteCommand> watchIncoming(String deviceId);
}
