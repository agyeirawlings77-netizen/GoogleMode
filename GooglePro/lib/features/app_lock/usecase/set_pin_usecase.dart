import 'package:injectable/injectable.dart';
import '../service/app_lock_service.dart';
@injectable
class SetPinUsecase {
  final AppLockService _svc;
  SetPinUsecase(this._svc);
  Future<void> call(String pin) => _svc.setPin(pin);
}
