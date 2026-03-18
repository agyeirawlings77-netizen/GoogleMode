import 'package:equatable/equatable.dart';
import '../model/app_lock_config.dart';
abstract class AppLockState extends Equatable {
  const AppLockState();
  @override List<Object?> get props => [];
}
class AppLockInitial extends AppLockState { const AppLockInitial(); }
class AppLockLocked extends AppLockState {
  final AppLockConfig config;
  const AppLockLocked(this.config);
  @override List<Object?> get props => [config];
}
class AppLockUnlocked extends AppLockState { const AppLockUnlocked(); }
class AppLockSetup extends AppLockState {
  final AppLockConfig config;
  const AppLockSetup(this.config);
  @override List<Object?> get props => [config];
}
class AppLockError extends AppLockState {
  final String message;
  const AppLockError(this.message);
  @override List<Object?> get props => [message];
}
class AppLockPinWrong extends AppLockState {
  final int attemptCount;
  const AppLockPinWrong(this.attemptCount);
  @override List<Object?> get props => [attemptCount];
}
