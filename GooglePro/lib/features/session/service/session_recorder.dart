import 'package:injectable/injectable.dart';
import '../../../core/utils/app_logger.dart';
@injectable
class SessionRecorder {
  bool _recording = false;
  bool get isRecording => _recording;
  Future<void> startRecording(String sessionId) async { _recording = true; AppLogger.info('Recording started: $sessionId'); }
  Future<String?> stopRecording() async { _recording = false; AppLogger.info('Recording stopped'); return null; }
}
