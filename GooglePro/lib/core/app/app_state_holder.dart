import 'package:flutter/foundation.dart';

class AppStateHolder extends ChangeNotifier {
  static final AppStateHolder _instance = AppStateHolder._();
  factory AppStateHolder() => _instance;
  AppStateHolder._();

  bool _isConnected = false;
  int _connectedDeviceCount = 0;
  String? _activeDeviceId;
  bool _isScreenSharing = false;
  bool _isViewing = false;

  bool get isConnected => _isConnected;
  int get connectedDeviceCount => _connectedDeviceCount;
  String? get activeDeviceId => _activeDeviceId;
  bool get isScreenSharing => _isScreenSharing;
  bool get isViewing => _isViewing;

  void setConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  void setConnectedDeviceCount(int count) {
    _connectedDeviceCount = count;
    notifyListeners();
  }

  void setActiveDevice(String? deviceId) {
    _activeDeviceId = deviceId;
    notifyListeners();
  }

  void setScreenSharing(bool value) {
    _isScreenSharing = value;
    notifyListeners();
  }

  void setViewing(bool value) {
    _isViewing = value;
    notifyListeners();
  }
}
