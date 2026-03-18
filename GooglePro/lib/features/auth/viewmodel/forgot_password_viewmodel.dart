import 'package:flutter/foundation.dart';
import '../validator/email_validator.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  String _email = '';
  bool _isLoading = false;
  String? _error;
  bool _emailSent = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get emailSent => _emailSent;
  String get email => _email;

  void onEmailChanged(String v) { _email = v; _error = null; notifyListeners(); }
  String? validateEmail() => EmailValidator.validate(_email);
  bool get isValid => validateEmail() == null;
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
  void setEmailSent(bool v) { _emailSent = v; notifyListeners(); }
}
