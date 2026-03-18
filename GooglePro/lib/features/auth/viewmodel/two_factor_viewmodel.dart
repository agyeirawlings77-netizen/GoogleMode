import 'package:flutter/foundation.dart';

class TwoFactorViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String _code = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get code => _code;
  bool get isCodeComplete => _code.length == 6;

  void onCodeChanged(String v) { _code = v; _error = null; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
}
