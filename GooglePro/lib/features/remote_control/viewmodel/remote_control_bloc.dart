import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/remote_control_service.dart';
import '../state/remote_control_state.dart';
import '../state/remote_control_event.dart';
import '../../../core/utils/app_logger.dart';

class RemoteControlBloc extends Bloc<RemoteControlEvent, RemoteControlState> {
  final RemoteControlService _svc;
  String? _deviceId;

  RemoteControlBloc(this._svc) : super(const RemoteControlIdle()) {
    on<EnableRemoteControlEvent>((e, emit) { _deviceId = e.deviceId; _svc.enable(); emit(RemoteControlActive(deviceId: e.deviceId)); });
    on<DisableRemoteControlEvent>((e, emit) { _svc.disable(); emit(const RemoteControlIdle()); });
    on<SendInputEventEvent>((e, emit) async {
      if (_deviceId == null) return;
      try { await _svc.sendInputEvent(_deviceId!, e.event); }
      catch (err) { AppLogger.error('Input send failed', err); }
    });
  }
}
