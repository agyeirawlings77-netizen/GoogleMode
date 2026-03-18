import 'package:injectable/injectable.dart';
import '../service/app_lock_service.dart';
@injectable
class VerifyPinUsecase {
  final AppLockService _svc;
  VerifyPinUsecase(this._svc);
  Future<bool> call(String pin) => _svc.verifyPin(pin);
  Future<bool> biometric() => _svc.verifyBiometric();
}
