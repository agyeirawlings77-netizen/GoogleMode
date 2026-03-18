import 'dart:async';
import 'dart:convert';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class DataChannelService {
  RTCDataChannel? _channel;
  final _messageController = StreamController<String>.broadcast();
  final _openController = StreamController<bool>.broadcast();

  Stream<String> get messages => _messageController.stream;
  Stream<bool> get openState => _openController.stream;
  bool get isOpen => _channel?.state == RTCDataChannelState.RTCDataChannelOpen;

  Future<void> createChannel(RTCPeerConnection pc, String label) async {
    _channel = await pc.createDataChannel(label, RTCDataChannelInit()..ordered = true);
    _setup();
  }

  void attachChannel(RTCDataChannel channel) {
    _channel = channel;
    _setup();
  }

  void _setup() {
    _channel?.onMessage = (msg) {
      if (msg.type == MessageType.text) _messageController.add(msg.text);
    };
    _channel?.onDataChannelState = (state) {
      _openController.add(state == RTCDataChannelState.RTCDataChannelOpen);
    };
  }

  void send(Map<String, dynamic> data) {
    if (!isOpen) { AppLogger.warning('DataChannel not open'); return; }
    try { _channel?.send(RTCDataChannelMessage(jsonEncode(data))); }
    catch (e) { AppLogger.error('DataChannel send failed', e); }
  }

  void sendText(String text) {
    if (!isOpen) return;
    _channel?.send(RTCDataChannelMessage(text));
  }

  void close() {
    _channel?.close();
    _channel = null;
  }

  void dispose() {
    close();
    _messageController.close();
    _openController.close();
  }
}
