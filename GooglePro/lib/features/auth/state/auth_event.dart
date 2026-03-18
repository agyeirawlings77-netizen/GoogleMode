import 'package:equatable/equatable.dart';
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override List<Object?> get props => [];
}
class CheckAuthEvent extends AuthEvent { const CheckAuthEvent(); }
class LoginEvent extends AuthEvent {
  final String email; final String password;
  const LoginEvent({required this.email, required this.password});
  @override List<Object?> get props => [email];
}
class RegisterEvent extends AuthEvent {
  final String name; final String email; final String password;
  const RegisterEvent({required this.name, required this.email, required this.password});
  @override List<Object?> get props => [email];
}
class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent(this.email);
  @override List<Object?> get props => [email];
}
class LogoutEvent extends AuthEvent { const LogoutEvent(); }
class BiometricLoginEvent extends AuthEvent { const BiometricLoginEvent(); }
class SendPhoneOtpEvent extends AuthEvent {
  final String phone;
  const SendPhoneOtpEvent(this.phone);
  @override List<Object?> get props => [phone];
}
class VerifyOtpEvent extends AuthEvent {
  final String verificationId; final String otp;
  const VerifyOtpEvent({required this.verificationId, required this.otp});
  @override List<Object?> get props => [otp];
}
