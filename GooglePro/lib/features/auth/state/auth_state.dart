import 'package:equatable/equatable.dart';
import '../model/auth_user.dart';
abstract class AuthState extends Equatable {
  const AuthState();
  @override List<Object?> get props => [];
}
class AuthInitial extends AuthState { const AuthInitial(); }
class AuthLoading extends AuthState { const AuthLoading(); }
class AuthAuthenticated extends AuthState {
  final AuthUser user;
  const AuthAuthenticated(this.user);
  @override List<Object?> get props => [user.uid];
}
class AuthUnauthenticated extends AuthState { const AuthUnauthenticated(); }
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override List<Object?> get props => [message];
}
class AuthEmailSent extends AuthState { const AuthEmailSent(); }
class AuthOtpSent extends AuthState {
  final String verificationId;
  const AuthOtpSent(this.verificationId);
  @override List<Object?> get props => [verificationId];
}
