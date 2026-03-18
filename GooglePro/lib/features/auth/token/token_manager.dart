import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../auth/model/auth_token.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class TokenManager {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token_data';
  TokenManager(this._storage);

  Future<void> saveToken(AuthToken token) async {
    await _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  Future<AuthToken?> getToken() async {
    try {
      final raw = await _storage.read(key: _tokenKey);
      if (raw == null) return null;
      return AuthToken.fromJson(jsonDecode(raw));
    } catch (e) { AppLogger.error('GetToken failed', e); return null; }
  }

  Future<String?> getValidAccessToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      return await user.getIdToken(false);
    } catch (e) { AppLogger.error('GetValidToken failed', e); return null; }
  }

  Future<String?> refreshToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      return await user.getIdToken(true);
    } catch (e) { AppLogger.error('RefreshToken failed', e); return null; }
  }

  Future<void> clearToken() async => _storage.delete(key: _tokenKey);

  Future<bool> isTokenValid() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
