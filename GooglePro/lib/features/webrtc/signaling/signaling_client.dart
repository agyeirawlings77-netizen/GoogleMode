import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';
import '../model/signaling_message.dart';

@singleton
class SignalingClient {
  WebSocketChannel? _channel;
  final _messageController = StreamController<SignalingMessage>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();
  bool _connected = false;
  String? _userId;
  Timer? _pingTimer;
  int _reconnectAttempts = 0;
  static const _maxReconnectAttempts = 10;

  Stream<SignalingMessage> get messages => _messageController.stream;
  Stream<bool> get connectionState => _connectionController.stream;
  bool get isConnected => _connected;

  Future<void> connect(String userId) async {
    _userId = userId;
    _reconnectAttempts = 0;
    await _connect();
  }

  Future<void> _connect() async {
    try {
      AppLogger.info('Signaling: connecting as $_userId');
      final uri = Uri.parse('${AppConstants.signalingWsUrl}?userId=$_userId');
      _channel = WebSocketChannel.connect(uri);
      _channel!.stream.listen(
        _onMessage,
        onError: (e) { AppLogger.error('Signaling WS error', e); _onDisconnected(); },
        onDone: () { AppLogger.info('Signaling WS closed'); _onDisconnected(); },
      );
      _connected = true;
      _reconnectAttempts = 0;
      _connectionController.add(true);
      _startPing();
      send(SignalingMessage(type: SignalingMessageType.hello, from: _userId!, to: 'server', timestamp: DateTime.now().millisecondsSinceEpoch));
      AppLogger.info('Signaling: connected');
    } catch (e, s) {
      AppLogger.error('Signaling connect failed', e, s);
      _onDisconnected();
    }
  }

  void _onMessage(dynamic raw) {
    if (raw is! String) return;
    final msg = SignalingMessage.tryParse(raw);
    if (msg == null) return;
    if (msg.type == SignalingMessageType.pong) return;
    _messageController.add(msg);
  }

  void _onDisconnected() {
    _connected = false;
    _pingTimer?.cancel();
    _connectionController.add(false);
    if (_reconnectAttempts < _maxReconnectAttempts && _userId != null) {
      _reconnectAttempts++;
      final delay = Duration(seconds: _reconnectAttempts * 2);
      AppLogger.info('Signaling: reconnecting in $delay (attempt $_reconnectAttempts)');
      Future.delayed(delay, _connect);
    }
  }

  void send(SignalingMessage msg) {
    if (!_connected || _channel == null) { AppLogger.warning('Signaling: cannot send, not connected'); return; }
    try { _channel!.sink.add(msg.toRaw()); }
    catch (e) { AppLogger.error('Signaling send failed', e); }
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      if (_connected && _userId != null) {
        send(SignalingMessage(type: SignalingMessageType.ping, from: _userId!, to: 'server', timestamp: DateTime.now().millisecondsSinceEpoch));
      }
    });
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    _userId = null;
    _connected = false;
    await _channel?.sink.close();
    _channel = null;
    _connectionController.add(false);
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}
