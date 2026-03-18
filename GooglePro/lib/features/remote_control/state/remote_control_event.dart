import 'package:equatable/equatable.dart';
import '../model/input_event.dart';
abstract class RemoteControlEvent extends Equatable {
  const RemoteControlEvent();
  @override List<Object?> get props => [];
}
class EnableRemoteControlEvent extends RemoteControlEvent {
  final String deviceId;
  const EnableRemoteControlEvent(this.deviceId);
  @override List<Object?> get props => [deviceId];
}
class DisableRemoteControlEvent extends RemoteControlEvent { const DisableRemoteControlEvent(); }
class SendInputEventEvent extends RemoteControlEvent {
  final InputEvent event;
  const SendInputEventEvent(this.event);
  @override List<Object?> get props => [event.timestamp];
}
