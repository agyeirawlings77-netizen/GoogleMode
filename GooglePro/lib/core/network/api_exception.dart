class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  const ApiException({required this.message, this.statusCode, this.data});

  factory ApiException.network() => const ApiException(message: 'No internet connection');
  factory ApiException.timeout() => const ApiException(message: 'Request timed out');
  factory ApiException.server() => const ApiException(message: 'Server error. Please try again.');
  factory ApiException.unauthorized() => const ApiException(message: 'Session expired. Please login again.', statusCode: 401);
  factory ApiException.notFound(String resource) => ApiException(message: '$resource not found', statusCode: 404);
  factory ApiException.fromStatusCode(int code) {
    switch (code) { case 401: return ApiException.unauthorized(); case 404: return const ApiException(message: 'Not found', statusCode: 404); case 500: return ApiException.server(); default: return ApiException(message: 'HTTP $code error', statusCode: code); }
  }

  @override String toString() => 'ApiException[$statusCode]: $message';
}
