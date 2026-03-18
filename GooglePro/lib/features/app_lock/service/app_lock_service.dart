import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import '../model/app_lock_config.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class AppLockService {
  final FlutterSecureStorage _storage;
  final LocalAuthentication _localAuth;
  static const _configKey = 'app_lock_config';
  bool _isLocked = false;

  AppLockService(this._storage, this._localAuth);

  bool get isLocked => _isLocked;

  Future<AppLockConfig> loadConfig() async {
    final raw = await _storage.read(key: _configKey);
    if (raw == null) return const AppLockConfig();
    try { return AppLockConfig.fromJson(jsonDecode(raw)); } catch (_) { return const AppLockConfig(); }
  }

  Future<void> saveConfig(AppLockConfig config) async {
    await _storage.write(key: _configKey, value: jsonEncode(config.toJson()));
  }

  Future<void> setupPin(String pin, AppLockConfig currentConfig) async {
    final hashed = _hashPin(pin);
    final updated = currentConfig.copyWith(lockType: LockType.pin, hashedPin: hashed);
    await saveConfig(updated);
    AppLogger.info('AppLock PIN set up');
  }

  Future<bool> verifyPin(String pin) async {
    final config = await loadConfig();
    if (config.hashedPin == null) return false;
    final hashed = _hashPin(pin);
    final correct = hashed == config.hashedPin;
    if (correct) { _isLocked = false; }
    return correct;
  }

  Future<bool> authenticateWithBiometric() async {
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Unlock GooglePro',
        options: const AuthenticationOptions(biometricOnly: false, stickyAuth: true),
      );
      if (result) _isLocked = false;
      return result;
    } catch (e) { AppLogger.error('Biometric auth failed', e); return false; }
  }

  void lock() { _isLocked = true; }
  void unlock() { _isLocked = false; }

  String _hashPin(String pin) => sha256.convert(utf8.encode('googlepro_$pin')).toString();
}
