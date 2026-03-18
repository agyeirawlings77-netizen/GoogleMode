import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/auth_service.dart';
import '../state/auth_state.dart';
import '../state/auth_event.dart';
import '../../../core/utils/app_logger.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _svc;
  AuthBloc(this._svc) : super(const AuthInitial()) {
    on<CheckAuthEvent>((e, emit) { final u = _svc.getCurrentUser(); emit(u != null ? AuthAuthenticated(u) : const AuthUnauthenticated()); });
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgotPasswordEvent>(_onForgot);
    on<LogoutEvent>((e, emit) async { await _svc.signOut(); emit(const AuthUnauthenticated()); });
    on<BiometricLoginEvent>((e, emit) { final u = _svc.getCurrentUser(); emit(u != null ? AuthAuthenticated(u) : const AuthError('No cached session')); });
    on<SendPhoneOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onLogin(LoginEvent e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try { emit(AuthAuthenticated(await _svc.signInWithEmail(e.email, e.password))); }
    catch (err) { AppLogger.error('Login failed', err); emit(AuthError(_map(err))); }
  }

  Future<void> _onRegister(RegisterEvent e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try { emit(AuthAuthenticated(await _svc.register(name: e.name, email: e.email, password: e.password))); }
    catch (err) { AppLogger.error('Register failed', err); emit(AuthError(_map(err))); }
  }

  Future<void> _onForgot(ForgotPasswordEvent e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try { await _svc.sendPasswordReset(e.email); emit(const AuthEmailSent()); }
    catch (err) { emit(AuthError(_map(err))); }
  }

  Future<void> _onSendOtp(SendPhoneOtpEvent e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await _svc.sendPhoneOtp(e.phone, (vid, _) => emit(AuthOtpSent(vid)), (ex) => emit(AuthError(ex.message ?? 'OTP failed')));
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent e, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try { emit(AuthAuthenticated(await _svc.verifyOtp(e.verificationId, e.otp))); }
    catch (err) { emit(AuthError(_map(err))); }
  }

  String _map(dynamic e) {
    final s = e.toString();
    if (s.contains('user-not-found')) return 'No account found with this email';
    if (s.contains('wrong-password')) return 'Incorrect password';
    if (s.contains('email-already-in-use')) return 'Email already registered';
    if (s.contains('weak-password')) return 'Password must be at least 8 characters';
    if (s.contains('network-request-failed')) return 'No internet connection';
    if (s.contains('too-many-requests')) return 'Too many attempts — try again later';
    if (s.contains('invalid-email')) return 'Invalid email address';
    return 'Something went wrong. Please try again';
  }
}
