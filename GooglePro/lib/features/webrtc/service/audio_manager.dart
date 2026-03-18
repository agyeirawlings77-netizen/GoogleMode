import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
@singleton
class AudioManager {
  bool _micEnabled = true;
  bool _speakerEnabled = true;
  bool get micEnabled => _micEnabled;
  bool get speakerEnabled => _speakerEnabled;
  void toggleMic(MediaStream? stream) {
    _micEnabled = !_micEnabled;
    stream?.getAudioTracks().forEach((t) => t.enabled = _micEnabled);
  }
  void toggleSpeaker(RTCPeerConnection? pc) {
    _speakerEnabled = !_speakerEnabled;
    Helper.setSpeakerphoneOn(_speakerEnabled);
  }
  void setMicEnabled(bool v, MediaStream? stream) {
    _micEnabled = v;
    stream?.getAudioTracks().forEach((t) => t.enabled = v);
  }
}
