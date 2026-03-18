import 'package:injectable/injectable.dart';
import '../../domain/entities/security_entity.dart';
import '../../domain/repositories/i_security_repository.dart';
import '../../features/app_lock/service/app_lock_service.dart';

@LazySingleton(as: ISecurityRepository)
class SecurityRepositoryImpl implements ISecurityRepository {
  final AppLockService _lockSvc;
  SecurityRepositoryImpl(this._lockSvc);
  @override Future<List<SecurityEventEntity>> getSecurityEvents(String deviceId) async => [];
  @override Future<void> logEvent(SecurityEventEntity event) async {}
  @override Future<bool> verifyPin(String pin) => _lockSvc.verifyPin(pin);
  @override Future<void> setPin(String pin) => _lockSvc.setPin(pin);
  @override Future<void> removePin() => _lockSvc.removeLock();
  @override Future<bool> verifyBiometric() => _lockSvc.verifyBiometric();
  @override Future<bool> isBiometricAvailable() async { try { return true; } catch (_) { return false; } }
}
