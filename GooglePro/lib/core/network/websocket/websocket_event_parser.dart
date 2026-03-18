import 'dart:convert';
import '../../utils/app_logger.dart';

class WebSocketEvent {
  final String type;
  final Map<String, dynamic> data;
  const WebSocketEvent({required this.type, required this.data});
}

class WebSocketEventParser {
  static WebSocketEvent? parse(String raw) {
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return WebSocketEvent(type: json['type'] ?? 'unknown', data: json);
    } catch (e) {
      AppLogger.warning('WS parse failed: $e');
      return null;
    }
  }

  static String serialize(String type, Map<String, dynamic> data) =>
    jsonEncode({'type': type, ...data, 'ts': DateTime.now().millisecondsSinceEpoch});
}
