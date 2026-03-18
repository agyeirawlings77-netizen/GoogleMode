import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';
import 'api_exception.dart';

@singleton
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.signalingApiUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'X-App-Version': '1.0.0'},
    ));
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (opts, handler) async {
          try {
            final token = await FirebaseAuth.instance.currentUser?.getIdToken();
            if (token != null) opts.headers['Authorization'] = 'Bearer $token';
          } catch (_) {}
          AppLogger.debug('API → ${opts.method} ${opts.path}');
          handler.next(opts);
        },
        onResponse: (resp, handler) {
          AppLogger.debug('API ← ${resp.statusCode} ${resp.requestOptions.path}');
          handler.next(resp);
        },
        onError: (err, handler) {
          AppLogger.error('API error: ${err.requestOptions.path}', err);
          handler.reject(err);
        },
      ),
    ]);
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? params, Options? options}) async {
    try { return await _dio.get<T>(path, queryParameters: params, options: options); }
    on DioException catch (e) { throw _mapError(e); }
  }

  Future<Response<T>> post<T>(String path, {dynamic data, Options? options}) async {
    try { return await _dio.post<T>(path, data: data, options: options); }
    on DioException catch (e) { throw _mapError(e); }
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) async {
    try { return await _dio.put<T>(path, data: data); }
    on DioException catch (e) { throw _mapError(e); }
  }

  Future<Response<T>> delete<T>(String path) async {
    try { return await _dio.delete<T>(path); }
    on DioException catch (e) { throw _mapError(e); }
  }

  ApiException _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout: return ApiException.timeout();
      case DioExceptionType.connectionError: return ApiException.network();
      case DioExceptionType.badResponse: return ApiException.fromStatusCode(e.response?.statusCode ?? 500);
      default: return ApiException(message: e.message ?? 'Unknown error');
    }
  }
}
