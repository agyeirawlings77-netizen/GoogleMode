class AppConstants {
  // Firebase
  static const firebaseProjectId    = 'pro-c76ee';
  static const firebaseAppId        = '1:458149596472:android:771af17fbc2a4434ac45cd';
  static const firebaseSenderId     = '458149596472';
  static const firebaseStorageBucket= 'pro-c76ee.appspot.com';
  static const firebaseApiKey       = 'AIzaSyCNRd8DGLWMVPo0cCpn1DSGNyiS-dUPwbw';
  static const firebaseWebApiKey    = 'AIzaSyBVDzvX3KhOmY8ujlbNC-jGoQX43aERmd8';
  static const firebaseRtdbUrl      = 'https://pro-c76ee-default-rtdb.firebaseio.com';
  // OAuth
  static const oauthClientId = '458149596472-r55k5k5adbac8j9qu6tbrhoo733daqu0.apps.googleusercontent.com';
  // Signaling
  static const signalingWsUrl  = 'wss://googlepro-signaling.onrender.com/ws';
  static const signalingApiUrl = 'https://googlepro-signaling.onrender.com/api/v1';
  // WebRTC
  static const stunUrl      = 'stun:relay.metered.ca:80';
  static const turnUrl      = 'turn:relay.metered.ca:80';
  static const turnUsername = 'adf231e2b5e252e24c33b810';
  static const turnPassword = 'NR5ZGh5pGsKnXBQX';
  // Gemini AI
  static const geminiApiKey = 'AIzaSyCA8KgvQApHxw6SkYCLU60ghmUMC4ZW51o';
  // Firebase RTDB Paths
  static const presencePath          = 'presence';
  static const signalsPath           = 'signals';
  static const autoConnectSignalsPath= 'auto_connect_signals';
  static const chatPath              = 'chat';
  // WorkManager
  static const wmAutoConnect       = 'googlepro_auto_connect';
  static const wmAutoConnectUnique = 'googlepro_auto_connect_unique';
  static const wmSync              = 'googlepro_sync';
  static const wmCleanup           = 'googlepro_cleanup';
  static const autoConnectIntervalMinutes = 15;
  // Storage keys
  static const trustedDevicesKey   = 'trusted_devices_v1';
  static const appPinKey           = 'app_pin_v1';
  static const biometricEnabledKey = 'biometric_enabled_v1';
  // Upload limits
  static const maxUploadSizeMb = 100;
  static const chunkSizeBytes  = 512 * 1024;
  // App
  static const packageName = 'com.rawlings.GooglePro';
  static const appName     = 'GooglePro';
}
