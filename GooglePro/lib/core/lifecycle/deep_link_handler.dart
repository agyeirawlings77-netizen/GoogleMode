import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class DeepLinkHandler {
  void handleUri(Uri uri, {required BuildContext context}) {
    AppLogger.info('Deep link: $uri');
    switch (uri.host) {
      case 'open':
        final route = uri.queryParameters['route'];
        if (route != null) context.push(route);
        break;
      case 'device':
        final deviceId = uri.pathSegments.firstOrNull;
        if (deviceId != null) context.push('/device/$deviceId');
        break;
      case 'session':
        final sessionId = uri.pathSegments.firstOrNull;
        if (sessionId != null) context.push('/session/$sessionId');
        break;
      default:
        AppLogger.warning('Unknown deep link host: ${uri.host}');
    }
  }
}

import 'package:flutter/material.dart' show BuildContext;
