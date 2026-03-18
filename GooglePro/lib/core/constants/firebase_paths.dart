class FirebasePaths {
  static String presence(String uid, String deviceId) => 'presence/$uid/$deviceId';
  static String signals(String uid) => 'signals/$uid';
  static String offer(String uid) => 'signals/$uid/offer';
  static String answer(String uid) => 'signals/$uid/answer';
  static String candidates(String uid) => 'signals/$uid/candidates';
  static String autoConnect(String uid) => 'auto_connect_signals/$uid';
  static String chat(String sessionId) => 'chat/$sessionId/messages';
  static String location(String uid) => 'presence/$uid/location';
}
