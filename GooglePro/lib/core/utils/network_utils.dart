import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  }

  static Future<String> getConnectionType() async {
    final result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.wifi)) return 'WiFi';
    if (result.contains(ConnectivityResult.mobile)) return 'Mobile';
    if (result.contains(ConnectivityResult.ethernet)) return 'Ethernet';
    return 'None';
  }

  static bool isPrivateIp(String ip) {
    if (ip.startsWith('192.168.') || ip.startsWith('10.') || ip.startsWith('172.')) return true;
    return false;
  }

  static String formatBitrate(double kbps) {
    if (kbps < 1000) return '${kbps.toStringAsFixed(0)} kbps';
    return '${(kbps / 1000).toStringAsFixed(1)} Mbps';
  }
}
