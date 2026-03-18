import 'package:flutter/foundation.dart';

class BiometricViewModel extends ChangeNotifier {
  bool _isAvailable = false;
  bool _isLoading = false;
  String? _error;

  bool get isAvailable => _isAvailable;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setAvailable(bool v) { _isAvailable = v; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
}
