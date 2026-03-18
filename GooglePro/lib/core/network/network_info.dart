import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class NetworkInfo {
  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get onConnectivityChanged =>
    Connectivity().onConnectivityChanged.map((e) => e.first);

  Future<ConnectivityResult> get connectionType async =>
    (await Connectivity().checkConnectivity()).first;
}
