import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../models/user_model.dart';

@singleton
class UserLocalDatasource {
  final FlutterSecureStorage _storage;
  static const _userKey = 'cached_user_v2';
  UserLocalDatasource(this._storage);

  Future<void> saveUser(UserModel user) => _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  Future<UserModel?> getUser() async {
    final raw = await _storage.read(key: _userKey);
    if (raw == null) return null;
    try { return UserModel.fromJson(jsonDecode(raw)); } catch (_) { return null; }
  }
  Future<void> clearUser() => _storage.delete(key: _userKey);
}
