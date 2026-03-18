import 'package:flutter/foundation.dart';
class DeviceRegistrationViewModel extends ChangeNotifier {
  String _deviceName = '';
  String _deviceType = 'phone';
  bool _isLoading = false;
  String? _error;
  String get deviceName => _deviceName;
  String get deviceType => _deviceType;
  bool get isLoading => _isLoading;
  String? get error => _error;
  void setDeviceName(String v) { _deviceName = v; notifyListeners(); }
  void setDeviceType(String v) { _deviceType = v; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
  bool get isValid => _deviceName.trim().length >= 2;
}
