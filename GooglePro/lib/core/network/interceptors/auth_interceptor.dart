import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/app_logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      AppLogger.warning('AuthInterceptor: token fetch failed: $e');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppLogger.warning('AuthInterceptor: 401 Unauthorized');
      // Could trigger re-auth here
    }
    handler.next(err);
  }
}
