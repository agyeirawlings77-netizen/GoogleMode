import 'package:injectable/injectable.dart';
import '../model/remote_command.dart';
import '../service/remote_control_service.dart';
@injectable
class SendCommandUsecase {
  final RemoteControlService _svc;
  SendCommandUsecase(this._svc);
  void call(RemoteCommand command) => _svc.sendCommand(command);
}
