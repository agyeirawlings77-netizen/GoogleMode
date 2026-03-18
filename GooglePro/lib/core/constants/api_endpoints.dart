class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://googlepro-signaling.onrender.com/api/v1';
  static const String wsUrl = 'wss://googlepro-signaling.onrender.com/ws';
  static const String health = '/health';
  static const String register = '/devices/register';
  static const String offer = '/signaling/offer';
  static const String answer = '/signaling/answer';
  static const String candidate = '/signaling/candidate';
  static const String sessions = '/sessions';
  static const String users = '/users';
  static String session(String id) => '/sessions/$id';
  static String device(String id) => '/devices/$id';
  static String userProfile(String uid) => '/users/$uid';
}
