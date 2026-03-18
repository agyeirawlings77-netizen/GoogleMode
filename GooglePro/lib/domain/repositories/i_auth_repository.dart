import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<String, UserEntity>> signInWithEmail(String email, String password);
  Future<Either<String, UserEntity>> register({required String name, required String email, required String password});
  Future<Either<String, void>> sendPasswordReset(String email);
  Future<Either<String, void>> signOut();
  Future<Either<String, UserEntity>> verifyOtp(String verificationId, String otp);
  Future<Either<String, UserEntity>> signInWithBiometric();
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
  Future<bool> isSignedIn();
}
