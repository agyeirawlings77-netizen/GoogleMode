import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../webrtc/model/signaling_message.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class WsSignalingService {
  WebSocketChannel? _channel;
  final _incomingCtrl = StreamController<SignalingMessage>.broadcast();
  final _connectedCtrl = StreamController<bool>.broadcast();
  bool _connected = false;
  int _reconnectCount = 0;
  Timer? _pingTimer;
  String? _uid;

  Stream<SignalingMessage> get incoming => _incomingCtrl.stream;
  Stream<bool> get connectionState => _connectedCtrl.stream;
  bool get isConnected => _connected;

  Future<void> connect(String uid) async {
    _uid = uid;
    _reconnectCount = 0;
    await _connect();
  }

  Future<void> _connect() async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';
      final url = '${AppConstants.signalingWsUrl}?uid=$_uid&token=$token';
      AppLogger.info('WS Signaling: connecting...');
      _channel = WebSocketChannel.connect(Uri.parse(url));
      await _channel!.ready;
      _connected = true;
      _reconnectCount = 0;
      _connectedCtrl.add(true);
      _startPing();
      _channel!.stream.listen(_onData, onError: (_) => _onDisconnect(), onDone: _onDisconnect);
      AppLogger.info('WS Signaling: connected');
    } catch (e) {
      AppLogger.error('WS Signaling connect failed', e);
      _onDisconnect();
    }
  }

  void _onData(dynamic raw) {
    if (raw is! String) return;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final type = json['type'] as String?;
      if (type == 'pong' || type == 'ping') return;
      final msg = SignalingMessage.fromJson(json);
      _incomingCtrl.add(msg);
      AppLogger.debug('WS signal received: ${msg.type.name}');
    } catch (e) { AppLogger.warning('WS parse error: $raw'); }
  }

  void _onDisconnect() {
    _connected = false;
    _pingTimer?.cancel();
    _connectedCtrl.add(false);
    if (_reconnectCount < 10 && _uid != null) {
      _reconnectCount++;
      AppLogger.info('WS reconnecting (${_reconnectCount}/10)...');
      Future.delayed(Duration(seconds: _reconnectCount * 2), _connect);
    }
  }

  void send(SignalingMessage msg) {
    if (!_connected) return;
    try { _channel?.sink.add(jsonEncode(msg.toJson())); }
    catch (e) { AppLogger.error('WS send failed', e); }
  }

  void sendOffer(String to, Map<String, dynamic> sdp) => send(SignalingMessage.offer(_uid ?? '', to, sdp));
  void sendAnswer(String to, Map<String, dynamic> sdp) => send(SignalingMessage.answer(_uid ?? '', to, sdp));
  void sendCandidate(String to, Map<String, dynamic> c) => send(SignalingMessage.candidate(_uid ?? '', to, c));
  void sendBye(String to) => send(SignalingMessage.bye(_uid ?? '', to));

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) { if (_connected) _channel?.sink.add(jsonEncode({'type': 'ping'})); });
  }

  Future<void> disconnect() async {
    _pingTimer?.cancel();
    _connected = false;
    await _channel?.sink.close();
    _channel = null;
  }

  void dispose() { disconnect(); _incomingCtrl.close(); _connectedCtrl.close(); }
}
