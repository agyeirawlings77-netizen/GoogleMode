import '../model/auth_user.dart';
abstract class AuthRepository {
  Future<AuthUser> signIn(String email, String password);
  Future<AuthUser> register({required String name, required String email, required String password});
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
  AuthUser? getCurrentUser();
  Stream<AuthUser?> get authStateChanges;
}
