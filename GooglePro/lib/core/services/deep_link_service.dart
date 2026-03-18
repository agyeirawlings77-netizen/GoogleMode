import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class DeepLinkService {
  void Function(String route, Map<String, String> params)? _handler;

  void register(void Function(String, Map<String, String>) handler) {
    _handler = handler;
    AppLogger.info('DeepLink handler registered');
  }

  void handle(String url) {
    try {
      final uri = Uri.parse(url);
      final route = uri.path;
      final params = uri.queryParameters;
      AppLogger.info('DeepLink: $route params=$params');
      _handler?.call(route, params);
    } catch (e) { AppLogger.error('DeepLink parse failed', e); }
  }

  String buildShareLink(String deviceId) => 'googlepro://pair?deviceId=$deviceId&ts=${DateTime.now().millisecondsSinceEpoch}';
  String buildSessionLink(String sessionId) => 'googlepro://session/$sessionId';
}
