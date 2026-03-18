import 'package:flutter/foundation.dart';

class OtpViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  int _resendCountdown = 60;
  bool _canResend = false;
  String _otp = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get resendCountdown => _resendCountdown;
  bool get canResend => _canResend;
  String get otp => _otp;
  bool get isOtpComplete => _otp.length == 6;

  void onOtpChanged(String v) { _otp = v; _error = null; notifyListeners(); }
  void setLoading(bool v) { _isLoading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }

  void startResendTimer() {
    _resendCountdown = 60; _canResend = false; notifyListeners();
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      _resendCountdown--;
      if (_resendCountdown <= 0) { _canResend = true; notifyListeners(); return false; }
      notifyListeners(); return true;
    });
  }
}
