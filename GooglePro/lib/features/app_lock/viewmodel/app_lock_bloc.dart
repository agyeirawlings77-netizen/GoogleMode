import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/app_lock_service.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../../../core/utils/app_logger.dart';

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  final AppLockService _service;
  int _failedAttempts = 0;

  AppLockBloc(this._service) : super(const AppLockInitial()) {
    on<CheckLockStatusEvent>(_onCheck);
    on<SubmitPinEvent>(_onSubmitPin);
    on<SetupPinEvent>(_onSetupPin);
    on<AuthenticateWithBiometricEvent>(_onBiometric);
    on<DisableLockEvent>(_onDisable);
    on<LockNowEvent>(_onLockNow);
  }

  Future<void> _onCheck(CheckLockStatusEvent e, Emitter<AppLockState> emit) async {
    final config = await _service.loadConfig();
    if (config.lockType != LockType.none && _service.isLocked) emit(AppLockLocked(config));
    else emit(const AppLockUnlocked());
  }

  Future<void> _onSubmitPin(SubmitPinEvent e, Emitter<AppLockState> emit) async {
    final correct = await _service.verifyPin(e.pin);
    if (correct) { _failedAttempts = 0; emit(const AppLockUnlocked()); }
    else { _failedAttempts++; emit(AppLockPinWrong(_failedAttempts)); AppLogger.warning('Wrong PIN attempt $_failedAttempts'); }
  }

  Future<void> _onSetupPin(SetupPinEvent e, Emitter<AppLockState> emit) async {
    final config = await _service.loadConfig();
    await _service.setupPin(e.pin, config);
    emit(AppLockSetup(config.copyWith(lockType: LockType.pin)));
  }

  Future<void> _onBiometric(AuthenticateWithBiometricEvent e, Emitter<AppLockState> emit) async {
    final ok = await _service.authenticateWithBiometric();
    if (ok) emit(const AppLockUnlocked());
    else emit(const AppLockError('Biometric authentication failed'));
  }

  Future<void> _onDisable(DisableLockEvent e, Emitter<AppLockState> emit) async {
    final config = await _service.loadConfig();
    await _service.saveConfig(config.copyWith(lockType: LockType.none, hashedPin: null));
    _service.unlock();
    emit(const AppLockUnlocked());
  }

  void _onLockNow(LockNowEvent e, Emitter<AppLockState> emit) async {
    _service.lock();
    final config = await _service.loadConfig();
    if (config.lockType != LockType.none) emit(AppLockLocked(config));
  }
}
