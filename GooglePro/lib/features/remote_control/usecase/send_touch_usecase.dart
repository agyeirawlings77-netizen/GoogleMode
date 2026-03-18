import 'package:injectable/injectable.dart';
import '../model/touch_event_model.dart';
import '../service/remote_control_service.dart';
@injectable
class SendTouchUsecase {
  final RemoteControlService _svc;
  SendTouchUsecase(this._svc);
  void call(TouchEventModel event) => _svc.sendTouchEvent(event);
}
