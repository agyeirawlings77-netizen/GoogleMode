import 'package:flutter/foundation.dart';
import '../state/login_ui_state.dart';
import '../validator/email_validator.dart';
import '../validator/password_validator.dart';

class LoginViewModel extends ChangeNotifier {
  LoginUiState _state = const LoginUiState();
  LoginUiState get state => _state;

  void onEmailChanged(String v) { _state = _state.copyWith(email: v, error: null); notifyListeners(); }
  void onPasswordChanged(String v) { _state = _state.copyWith(password: v, error: null); notifyListeners(); }
  void togglePassword() { _state = _state.copyWith(obscurePassword: !_state.obscurePassword); notifyListeners(); }
  void toggleRememberMe() { _state = _state.copyWith(rememberMe: !_state.rememberMe); notifyListeners(); }

  String? validateEmail() => EmailValidator.validate(_state.email);
  String? validatePassword() => PasswordValidator.validate(_state.password);

  bool get isFormValid => validateEmail() == null && validatePassword() == null;
}
