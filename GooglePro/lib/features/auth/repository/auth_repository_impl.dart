import 'package:injectable/injectable.dart';
import '../service/auth_service.dart';
import '../model/auth_user.dart';
import 'auth_repository.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _svc;
  AuthRepositoryImpl(this._svc);
  @override Future<AuthUser> signIn(String e, String p) => _svc.signInWithEmail(e, p);
  @override Future<AuthUser> register({required String name, required String email, required String password}) => _svc.register(name: name, email: email, password: password);
  @override Future<void> sendPasswordReset(String e) => _svc.sendPasswordReset(e);
  @override Future<void> signOut() => _svc.signOut();
  @override AuthUser? getCurrentUser() => _svc.getCurrentUser();
  @override Stream<AuthUser?> get authStateChanges => _svc.authStateChanges;
}
