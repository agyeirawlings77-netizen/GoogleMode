import 'dart:io';
import 'package:dio/dio.dart';
import 'app_exception.dart';
import 'failure.dart';
import '../utils/app_logger.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    AppLogger.error('Error handled', error);
    if (error is DioException) return _handleDio(error);
    if (error is SocketException) return const NetworkFailure('No internet connection');
    if (error is HttpException) return const NetworkFailure('HTTP error');
    if (error is FormatException) return const ServerFailure('Invalid data format');
    if (error is AppException) return _handleAppException(error);
    return UnknownFailure(error?.toString() ?? 'Unknown error');
  }

  static Failure _handleDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();
      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection failed');
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        if (status == 401) return const AuthFailure('Unauthorized');
        if (status == 403) return const PermissionFailure('Forbidden');
        if (status == 404) return const ServerFailure('Not found');
        if (status != null && status >= 500) return ServerFailure('Server error ($status)');
        return const ServerFailure();
      default:
        return const NetworkFailure();
    }
  }

  static Failure _handleAppException(AppException e) {
    if (e is NetworkException) return NetworkFailure(e.message);
    if (e is AuthException) return AuthFailure(e.message);
    if (e is ServerException) return ServerFailure(e.message);
    if (e is PermissionException) return PermissionFailure(e.message);
    if (e is TimeoutException) return TimeoutFailure(e.message);
    return UnknownFailure(e.message);
  }

  static String friendlyMessage(dynamic error) => handle(error).message;
}
