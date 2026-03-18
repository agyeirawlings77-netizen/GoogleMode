import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import 'interceptors.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    final d = Dio(BaseOptions(baseUrl: AppConstants.signalingApiUrl, connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 30)));
    d.interceptors.addAll([AuthInterceptor(), RetryInterceptor(d)]);
    return d;
  }
}
