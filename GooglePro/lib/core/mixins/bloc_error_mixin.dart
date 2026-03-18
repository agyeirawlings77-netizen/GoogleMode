import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_logger.dart';

mixin BlocErrorMixin<E, S> on Bloc<E, S> {
  void logError(String context, dynamic error, [StackTrace? stack]) {
    AppLogger.error('[$runtimeType] $context', error, stack);
  }

  String friendlyError(dynamic error) {
    final s = error.toString();
    if (s.contains('network') || s.contains('socket')) return 'No internet connection';
    if (s.contains('timeout')) return 'Request timed out';
    if (s.contains('permission')) return 'Permission denied';
    if (s.contains('unauthenticated') || s.contains('401')) return 'Session expired. Please login again.';
    return 'Something went wrong. Please try again.';
  }
}
