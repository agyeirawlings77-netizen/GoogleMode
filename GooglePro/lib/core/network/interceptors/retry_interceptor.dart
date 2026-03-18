import 'package:dio/dio.dart';
import '../../utils/app_logger.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({required this.dio, this.maxRetries = 3, this.retryDelay = const Duration(seconds: 1)});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    if (retryCount < maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(retryDelay * (retryCount + 1));
      try {
        AppLogger.debug('Retrying request (${retryCount + 1}/$maxRetries): ${err.requestOptions.uri}');
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) { /* Fall through to next handler */ }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException e) =>
    e.type == DioExceptionType.connectionTimeout ||
    e.type == DioExceptionType.receiveTimeout ||
    e.type == DioExceptionType.sendTimeout ||
    (e.response?.statusCode != null && e.response!.statusCode! >= 500);
}
