import 'package:equatable/equatable.dart';
abstract class AppLockEvent extends Equatable {
  const AppLockEvent();
  @override List<Object?> get props => [];
}
class CheckLockStatusEvent extends AppLockEvent { const CheckLockStatusEvent(); }
class SubmitPinEvent extends AppLockEvent {
  final String pin;
  const SubmitPinEvent(this.pin);
  @override List<Object?> get props => [pin];
}
class SetupPinEvent extends AppLockEvent {
  final String pin;
  const SetupPinEvent(this.pin);
  @override List<Object?> get props => [pin];
}
class AuthenticateWithBiometricEvent extends AppLockEvent { const AuthenticateWithBiometricEvent(); }
class DisableLockEvent extends AppLockEvent { const DisableLockEvent(); }
class LockNowEvent extends AppLockEvent { const LockNowEvent(); }
