import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class ConnectivityService {
  final _connectivity = Connectivity();
  ConnectivityResult _current = ConnectivityResult.none;
  final _ctrl = StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get onStatusChange => _ctrl.stream;
  ConnectivityResult get current => _current;
  bool get isConnected => _current != ConnectivityResult.none;
  bool get isWifi => _current == ConnectivityResult.wifi;
  bool get isMobile => _current == ConnectivityResult.mobile;

  Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    _current = result.first;
    _connectivity.onConnectivityChanged.listen((results) {
      final r = results.first;
      if (r != _current) {
        _current = r;
        _ctrl.add(r);
        AppLogger.info('Connectivity changed: $r');
      }
    });
    AppLogger.info('Connectivity: $_current');
  }

  Future<bool> checkConnection() async {
    final r = await _connectivity.checkConnectivity();
    _current = r.first;
    return isConnected;
  }

  void dispose() => _ctrl.close();
}
