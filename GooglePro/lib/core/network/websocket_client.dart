import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/app_logger.dart';

@singleton
class WebSocketClient {
  WebSocketChannel? _channel;
  final _controller = StreamController<String>.broadcast();
  bool _connected = false;
  Stream<String> get messages => _controller.stream;
  bool get isConnected => _connected;

  Future<void> connect(String url) async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _connected = true;
      _channel!.stream.listen((m) { if (m is String) _controller.add(m); }, onError: (_) => _connected = false, onDone: () => _connected = false);
    } catch (e) { AppLogger.error('WS connect failed', e); _connected = false; }
  }

  void send(String message) {
    if (!_connected) return;
    try { _channel?.sink.add(message); } catch (e) { AppLogger.error('WS send failed', e); }
  }

  Future<void> close() async { _connected = false; await _channel?.sink.close(); _channel = null; }
  void dispose() { close(); _controller.close(); }
}
