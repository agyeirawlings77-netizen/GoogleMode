import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenStorage {
  final FlutterSecureStorage _storage;
  static const _refreshKey = 'refresh_token';
  static const _userIdKey = 'token_user_id';
  TokenStorage(this._storage);

  Future<void> saveRefreshToken(String token) => _storage.write(key: _refreshKey, value: token);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);
  Future<void> saveUserId(String uid) => _storage.write(key: _userIdKey, value: uid);
  Future<String?> getUserId() => _storage.read(key: _userIdKey);
  Future<void> clear() => _storage.deleteAll();
}
