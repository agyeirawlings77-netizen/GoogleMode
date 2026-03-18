import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

enum NetworkStatus { connected, disconnected, wifi, mobile, ethernet }

@singleton
class NetworkMonitor {
  final _controller = StreamController<NetworkStatus>.broadcast();
  NetworkStatus _current = NetworkStatus.disconnected;
  StreamSubscription? _sub;

  Stream<NetworkStatus> get statusStream => _controller.stream;
  NetworkStatus get current => _current;
  bool get isConnected => _current != NetworkStatus.disconnected;

  Future<void> initialize() async {
    final result = await Connectivity().checkConnectivity();
    _current = _map(result);
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final status = _map(results.first);
      if (status != _current) {
        _current = status;
        _controller.add(status);
        AppLogger.info('Network: $status');
      }
    });
    AppLogger.info('NetworkMonitor initialized: $_current');
  }

  NetworkStatus _map(ConnectivityResult r) {
    switch (r) {
      case ConnectivityResult.wifi: return NetworkStatus.wifi;
      case ConnectivityResult.mobile: return NetworkStatus.mobile;
      case ConnectivityResult.ethernet: return NetworkStatus.ethernet;
      case ConnectivityResult.none: return NetworkStatus.disconnected;
      default: return NetworkStatus.connected;
    }
  }

  void dispose() { _sub?.cancel(); _controller.close(); }
}
