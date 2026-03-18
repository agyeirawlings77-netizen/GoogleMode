import 'package:flutter/foundation.dart';
import '../model/peer_connection_state.dart';
import '../model/connection_stats.dart';
class ConnectionViewModel extends ChangeNotifier {
  PeerConnectionState _state = PeerConnectionState.idle;
  ConnectionStats _stats = const ConnectionStats();
  bool _showStats = false;
  PeerConnectionState get state => _state;
  ConnectionStats get stats => _stats;
  bool get showStats => _showStats;
  void setState(PeerConnectionState v) { _state = v; notifyListeners(); }
  void setStats(ConnectionStats v) { _stats = v; notifyListeners(); }
  void toggleStats() { _showStats = !_showStats; notifyListeners(); }
}
