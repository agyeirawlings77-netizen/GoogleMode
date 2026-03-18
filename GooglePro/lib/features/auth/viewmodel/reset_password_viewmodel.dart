import 'package:flutter/foundation.dart';
import '../validator/password_validator.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _done = false;
  String _password = '', _confirm = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get done => _done;

  void onPasswordChanged(String v) { _password = v; _error = null; notifyListeners(); }
  void onConfirmChanged(String v) { _confirm = v; _error = null; notifyListeners(); }
  String? validatePassword() => PasswordValidator.validate(_password);
  String? validateConfirm() => PasswordValidator.validateConfirm(_confirm, _password);
  bool get isValid => validatePassword() == null && validateConfirm() == null;
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
  void setDone(bool v) { _done = v; notifyListeners(); }
}
