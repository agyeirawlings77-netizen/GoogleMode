import 'package:flutter/foundation.dart';
import '../model/trusted_device_model.dart';
class TrustedDeviceViewModel extends ChangeNotifier {
  List<TrustedDeviceModel> _devices = [];
  bool _isLoading = false;
  String? _error;
  List<TrustedDeviceModel> get devices => _devices;
  bool get isLoading => _isLoading;
  String? get error => _error;
  void setDevices(List<TrustedDeviceModel> v) { _devices = v; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
  int get onlineCount => 0;
}
