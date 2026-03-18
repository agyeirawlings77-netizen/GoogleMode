import 'dart:async';
import 'package:injectable/injectable.dart';
import '../model/peer_connection_state.dart';
import '../../../core/utils/app_logger.dart';
@injectable
class ReconnectManager {
  int _attempts = 0;
  static const _maxAttempts = 5;
  Timer? _timer;
  void Function()? onReconnect;

  void handleStateChange(PeerConnectionState state) {
    if (state.isFailed && _attempts < _maxAttempts) {
      _attempts++;
      final delay = Duration(seconds: _attempts * 2);
      AppLogger.info('Reconnecting in $delay (attempt $_attempts)');
      _timer?.cancel();
      _timer = Timer(delay, () => onReconnect?.call());
    }
  }

  void reset() { _attempts = 0; _timer?.cancel(); }
  void dispose() { _timer?.cancel(); }
}
