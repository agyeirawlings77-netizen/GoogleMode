import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/webrtc_config.dart';
import '../model/peer_connection_state.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class PeerConnectionManager {
  final Map<String, RTCPeerConnection> _connections = {};
  final _stateController = StreamController<Map<String, PeerConnectionState>>.broadcast();
  final Map<String, PeerConnectionState> _states = {};

  Stream<Map<String, PeerConnectionState>> get states => _stateController.stream;

  Future<RTCPeerConnection> createConnection(String peerId) async {
    await closeConnection(peerId);
    final pc = await createPeerConnection(WebRtcConfig.iceServers, WebRtcConfig.sdpConstraints);
    _connections[peerId] = pc;
    _states[peerId] = PeerConnectionState.connecting;
    pc.onConnectionState = (s) {
      final mapped = _mapState(s);
      _states[peerId] = mapped;
      _stateController.add(Map.from(_states));
      AppLogger.info('PC[$peerId]: $mapped');
    };
    return pc;
  }

  RTCPeerConnection? getConnection(String peerId) => _connections[peerId];

  Future<void> closeConnection(String peerId) async {
    await _connections[peerId]?.close();
    _connections.remove(peerId);
    _states.remove(peerId);
    _stateController.add(Map.from(_states));
  }

  PeerConnectionState _mapState(RTCPeerConnectionState s) {
    switch (s) {
      case RTCPeerConnectionState.RTCPeerConnectionStateConnected: return PeerConnectionState.connected;
      case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected: return PeerConnectionState.disconnected;
      case RTCPeerConnectionState.RTCPeerConnectionStateFailed: return PeerConnectionState.failed;
      case RTCPeerConnectionState.RTCPeerConnectionStateClosed: return PeerConnectionState.closed;
      default: return PeerConnectionState.connecting;
    }
  }

  void dispose() {
    for (final pc in _connections.values) pc.close();
    _connections.clear();
    _stateController.close();
  }
}
