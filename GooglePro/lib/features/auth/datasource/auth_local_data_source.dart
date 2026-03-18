import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../model/auth_user.dart';

@singleton
class AuthLocalDataSource {
  final FlutterSecureStorage _storage;
  static const _userKey = 'cached_user';
  static const _biometricKey = 'biometric_enabled';
  AuthLocalDataSource(this._storage);

  Future<void> saveUser(AuthUser user) =>
      _storage.write(key: _userKey, value: jsonEncode(user.toJson()));

  Future<AuthUser?> getUser() async {
    final raw = await _storage.read(key: _userKey);
    if (raw == null) return null;
    try { return AuthUser.fromJson(jsonDecode(raw)); } catch (_) { return null; }
  }

  Future<void> clearUser() => _storage.delete(key: _userKey);

  Future<void> setBiometricEnabled(bool enabled) =>
      _storage.write(key: _biometricKey, value: enabled.toString());

  Future<bool> isBiometricEnabled() async {
    final val = await _storage.read(key: _biometricKey);
    return val == 'true';
  }
}
