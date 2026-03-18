import 'package:injectable/injectable.dart';
import '../datasource/auth_local_data_source.dart';
import '../model/auth_user.dart';

@singleton
class AuthLocalRepository {
  final AuthLocalDataSource _local;
  AuthLocalRepository(this._local);
  Future<AuthUser?> getCachedUser() => _local.getUser();
  Future<void> saveUser(AuthUser user) => _local.saveUser(user);
  Future<void> clearUser() => _local.clearUser();
  Future<bool> isBiometricEnabled() => _local.isBiometricEnabled();
}
