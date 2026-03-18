import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'failures.dart';
import '../utils/app_logger.dart';

class ErrorHandler {
  static Failure handle(dynamic error, [StackTrace? stack]) {
    AppLogger.error('Error handled', error, stack);
    if (error is FirebaseAuthException) return _handleFirebaseAuth(error);
    if (error is DioException) return _handleDio(error);
    if (error is FormatException) return const ValidationFailure('Invalid data format');
    final msg = error?.toString() ?? 'Unknown error';
    if (msg.contains('network') || msg.contains('socket') || msg.contains('connection')) return NetworkFailure(msg);
    if (msg.contains('timeout')) return const TimeoutFailure();
    if (msg.contains('permission')) return PermissionFailure(msg);
    return UnknownFailure(msg);
  }

  static Either<Failure, T> safe<T>(T Function() fn) { try { return Right(fn()); } catch (e, s) { return Left(handle(e, s)); } }
  static Future<Either<Failure, T>> safeAsync<T>(Future<T> Function() fn) async { try { return Right(await fn()); } catch (e, s) { return Left(handle(e, s)); } }

  static Failure _handleFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found': return const AuthFailure('No account found with this email');
      case 'wrong-password': return const AuthFailure('Incorrect password');
      case 'email-already-in-use': return const AuthFailure('Email already registered');
      case 'weak-password': return const AuthFailure('Password too weak (min 8 chars)');
      case 'network-request-failed': return const NetworkFailure();
      case 'too-many-requests': return const AuthFailure('Too many attempts. Try again later.');
      default: return AuthFailure(e.message ?? 'Authentication failed');
    }
  }

  static Failure _handleDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout: return const TimeoutFailure();
      case DioExceptionType.connectionError: return const NetworkFailure();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 500;
        if (code == 401) return const AuthFailure('Session expired. Please login.');
        if (code == 404) return const NotFoundFailure();
        return ServerFailure('Server error ($code)');
      default: return NetworkFailure(e.message ?? 'Network error');
    }
  }
}
