import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class AppSessionManager {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _sessionActiveKey = 'session_active';

  AppSessionManager(this._storage);

  Future<void> saveSession(String userId, String token) async {
    await _storage.write(key: _userIdKey, value: userId);
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _sessionActiveKey, value: 'true');
    AppLogger.info('Session saved for $userId');
  }

  Future<bool> isSessionActive() async {
    final val = await _storage.read(key: _sessionActiveKey);
    final user = FirebaseAuth.instance.currentUser;
    return val == 'true' && user != null;
  }

  Future<String?> getSavedUserId() async =>
      _storage.read(key: _userIdKey);

  Future<String?> getSavedToken() async =>
      _storage.read(key: _tokenKey);

  Future<void> clearSession() async {
    await _storage.deleteAll();
    AppLogger.info('Session cleared');
  }
}
