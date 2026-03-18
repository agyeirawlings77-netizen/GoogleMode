import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class VoiceCallService {
  RTCPeerConnection? _pc;
  MediaStream? _localStream;
  bool _muted = false;
  bool _speakerOn = false;

  bool get isMuted => _muted;
  bool get isSpeakerOn => _speakerOn;

  Future<MediaStream> startAudioStream() async {
    _localStream = await navigator.mediaDevices.getUserMedia({'video': false, 'audio': {'echoCancellation': true, 'noiseSuppression': true, 'autoGainControl': true}});
    AppLogger.info('Audio stream started');
    return _localStream!;
  }

  void setMuted(bool muted) {
    _muted = muted;
    _localStream?.getAudioTracks().forEach((t) => t.enabled = !muted);
    AppLogger.debug('Muted: $muted');
  }

  void setSpeaker(bool speaker) {
    _speakerOn = speaker;
    AppLogger.debug('Speaker: $speaker');
  }

  void toggleMute() => setMuted(!_muted);
  void toggleSpeaker() => setSpeaker(!_speakerOn);

  Future<void> endCall() async {
    _localStream?.getTracks().forEach((t) => t.stop());
    await _localStream?.dispose();
    _localStream = null;
    await _pc?.close();
    _pc = null;
    AppLogger.info('Voice call ended');
  }

  void dispose() => endCall();
}
