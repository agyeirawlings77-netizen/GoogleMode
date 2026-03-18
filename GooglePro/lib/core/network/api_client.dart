import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import '../utils/app_logger.dart';

@singleton
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.signalingApiUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (opts, handler) { AppLogger.debug('API → ${opts.method} ${opts.path}'); handler.next(opts); },
      onResponse: (resp, handler) { AppLogger.debug('API ← ${resp.statusCode} ${resp.requestOptions.path}'); handler.next(resp); },
      onError: (err, handler) { AppLogger.error('API error ${err.requestOptions.path}', err); handler.next(err); },
    ));
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? params}) => _dio.get(path, queryParameters: params);
  Future<Response<T>> post<T>(String path, {dynamic data}) => _dio.post(path, data: data);
  Future<Response<T>> put<T>(String path, {dynamic data}) => _dio.put(path, data: data);
  Future<Response<T>> delete<T>(String path) => _dio.delete(path);
}
