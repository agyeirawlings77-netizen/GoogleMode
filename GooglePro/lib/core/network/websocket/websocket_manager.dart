import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../utils/app_logger.dart';
import '../../constants/app_constants.dart';

enum WsConnectionState { disconnected, connecting, connected, reconnecting }

@singleton
class WebSocketManager {
  WebSocketChannel? _channel;
  WsConnectionState _state = WsConnectionState.disconnected;
  final _messageController = StreamController<String>.broadcast();
  final _stateController = StreamController<WsConnectionState>.broadcast();
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  String? _userId;
  static const _maxReconnectAttempts = 10;
  static const _pingIntervalSeconds = 25;

  Stream<String> get messages => _messageController.stream;
  Stream<WsConnectionState> get stateStream => _stateController.stream;
  WsConnectionState get state => _state;
  bool get isConnected => _state == WsConnectionState.connected;

  Future<void> connect(String userId) async {
    _userId = userId;
    _reconnectAttempts = 0;
    await _connect();
  }

  Future<void> _connect() async {
    _setState(WsConnectionState.connecting);
    try {
      final uri = Uri.parse('${AppConstants.signalingWsUrl}?userId=$_userId');
      _channel = WebSocketChannel.connect(uri);
      _channel!.stream.listen(
        _onMessage,
        onError: (e) { AppLogger.error('WS error', e); _onDisconnect(); },
        onDone: () { AppLogger.info('WS closed'); _onDisconnect(); },
      );
      _setState(WsConnectionState.connected);
      _reconnectAttempts = 0;
      _startPing();
      AppLogger.info('WS connected as $_userId');
    } catch (e, s) {
      AppLogger.error('WS connect failed', e, s);
      _onDisconnect();
    }
  }

  void _onMessage(dynamic raw) {
    if (raw is String) _messageController.add(raw);
  }

  void _onDisconnect() {
    _setState(WsConnectionState.disconnected);
    _pingTimer?.cancel();
    if (_reconnectAttempts < _maxReconnectAttempts && _userId != null) {
      _reconnectAttempts++;
      final delay = Duration(seconds: (_reconnectAttempts * 2).clamp(1, 30));
      _setState(WsConnectionState.reconnecting);
      AppLogger.info('WS reconnecting in $delay (attempt $_reconnectAttempts)');
      _reconnectTimer = Timer(delay, _connect);
    }
  }

  void send(String message) {
    if (!isConnected) { AppLogger.warning('WS not connected — cannot send'); return; }
    try { _channel?.sink.add(message); }
    catch (e) { AppLogger.error('WS send failed', e); }
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: _pingIntervalSeconds), (_) {
      if (isConnected) send('{"type":"ping","ts":${DateTime.now().millisecondsSinceEpoch}}');
    });
  }

  void _setState(WsConnectionState s) { _state = s; _stateController.add(s); }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _userId = null;
    await _channel?.sink.close();
    _channel = null;
    _setState(WsConnectionState.disconnected);
    AppLogger.info('WS disconnected');
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _stateController.close();
  }
}
