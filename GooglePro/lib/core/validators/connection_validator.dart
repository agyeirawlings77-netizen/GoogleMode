class ConnectionValidator {
  static bool isValidWebSocketUrl(String url) => url.startsWith('wss://') || url.startsWith('ws://');
  static bool isValidTurnUrl(String url) => url.startsWith('turn:') || url.startsWith('turns:');
  static bool isValidStunUrl(String url) => url.startsWith('stun:') || url.startsWith('stuns:');
  static bool isValidBitrate(int kbps) => kbps >= 100 && kbps <= 20000;
  static bool isValidFps(int fps) => fps >= 1 && fps <= 60;
  static bool isValidTimeout(int seconds) => seconds >= 5 && seconds <= 120;
  static bool isValidIceCandidate(Map<String, dynamic> candidate) =>
    candidate.containsKey('candidate') && candidate.containsKey('sdpMid') && candidate.containsKey('sdpMLineIndex');
}
