import 'package:flutter/foundation.dart';
import '../state/register_ui_state.dart';
import '../validator/email_validator.dart';
import '../validator/password_validator.dart';
import '../validator/name_validator.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterUiState _state = const RegisterUiState();
  RegisterUiState get state => _state;
  String _name = '', _email = '', _password = '', _confirm = '';

  void onNameChanged(String v) { _name = v; notifyListeners(); }
  void onEmailChanged(String v) { _email = v; notifyListeners(); }
  void onPasswordChanged(String v) { _password = v; notifyListeners(); }
  void onConfirmChanged(String v) { _confirm = v; notifyListeners(); }
  void togglePassword() { _state = _state.copyWith(obscurePassword: !_state.obscurePassword); notifyListeners(); }
  void toggleConfirm() { _state = _state.copyWith(obscureConfirm: !_state.obscureConfirm); notifyListeners(); }

  String? validateName() => NameValidator.validate(_name);
  String? validateEmail() => EmailValidator.validate(_email);
  String? validatePassword() => PasswordValidator.validate(_password);
  String? validateConfirm() => PasswordValidator.validateConfirm(_confirm, _password);

  String get name => _name;
  String get email => _email;
  String get password => _password;

  bool get isFormValid => validateName() == null && validateEmail() == null &&
      validatePassword() == null && validateConfirm() == null;
}
