import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../datasources/local/user_local_datasource.dart';
import '../mappers/user_mapper.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../core/utils/app_logger.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _auth;
  final UserRemoteDatasource _remote;
  final UserLocalDatasource _local;
  final LocalAuthentication _localAuth;
  String? _pendingVerificationId;

  AuthRepositoryImpl(this._auth, this._remote, this._local, this._localAuth);

  @override
  Future<Either<String, UserEntity>> signInWithEmail(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = UserMapper.fromFirebase(cred.user!);
      await _local.saveUser(user);
      await _remote.updateUser(user.uid, {'lastLogin': DateTime.now().toIso8601String()});
      return Right(user);
    } catch (e) { return Left(_mapAuthError(e)); }
  }

  @override
  Future<Either<String, UserEntity>> register({required String name, required String email, required String password}) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user?.updateDisplayName(name);
      final user = UserMapper.fromFirebase(cred.user!).copyWith(displayName: name);
      await _remote.createUser(user);
      await _local.saveUser(user);
      return Right(user);
    } catch (e) { return Left(_mapAuthError(e)); }
  }

  @override
  Future<Either<String, void>> sendPasswordReset(String email) async {
    try { await _auth.sendPasswordResetEmail(email: email); return const Right(null); }
    catch (e) { return Left(_mapAuthError(e)); }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try { await _auth.signOut(); await _local.clearUser(); return const Right(null); }
    catch (e) { return Left(e.toString()); }
  }

  @override
  Future<Either<String, UserEntity>> verifyOtp(String verificationId, String otp) async {
    try {
      final cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
      final result = await _auth.signInWithCredential(cred);
      return Right(UserMapper.fromFirebase(result.user!));
    } catch (e) { return Left(_mapAuthError(e)); }
  }

  @override
  Future<Either<String, UserEntity>> signInWithBiometric() async {
    try {
      final ok = await _localAuth.authenticate(localizedReason: 'Authenticate to access GooglePro', options: const AuthenticationOptions(biometricOnly: false, stickyAuth: true));
      if (!ok) return const Left('Biometric authentication failed');
      final user = _auth.currentUser;
      if (user == null) return const Left('No cached session');
      return Right(UserMapper.fromFirebase(user));
    } catch (e) { return Left(e.toString()); }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) return UserMapper.fromFirebase(firebaseUser);
    return _local.getUser();
  }

  @override Stream<UserEntity?> get authStateChanges => _auth.authStateChanges().map((u) => u != null ? UserMapper.fromFirebase(u) : null);
  @override Future<bool> isSignedIn() async => _auth.currentUser != null;

  String _mapAuthError(dynamic e) {
    final msg = e.toString();
    if (msg.contains('user-not-found')) return 'No account found';
    if (msg.contains('wrong-password')) return 'Incorrect password';
    if (msg.contains('email-already-in-use')) return 'Email already registered';
    if (msg.contains('weak-password')) return 'Password too weak';
    if (msg.contains('network-request-failed')) return 'No internet connection';
    return 'Authentication failed. Please try again.';
  }
}
