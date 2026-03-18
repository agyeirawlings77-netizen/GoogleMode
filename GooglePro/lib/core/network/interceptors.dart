import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/app_logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) options.headers['Authorization'] = 'Bearer $token';
    } catch (e) { AppLogger.warning('Auth interceptor: $e'); }
    handler.next(options);
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  RetryInterceptor(this.dio, {this.maxRetries = 3});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    if (retryCount < maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(Duration(seconds: retryCount + 1));
      try {
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (_) {}
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException e) => e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || (e.response?.statusCode ?? 0) >= 500;
}
