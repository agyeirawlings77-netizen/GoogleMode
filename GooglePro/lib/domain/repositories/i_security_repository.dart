import '../entities/security_entity.dart';

abstract class ISecurityRepository {
  Future<List<SecurityEventEntity>> getSecurityEvents(String deviceId);
  Future<void> logEvent(SecurityEventEntity event);
  Future<bool> verifyPin(String pin);
  Future<void> setPin(String pin);
  Future<void> removePin();
  Future<bool> verifyBiometric();
  Future<bool> isBiometricAvailable();
}
