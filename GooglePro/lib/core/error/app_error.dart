class AppError {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;
  const AppError({required this.message, this.code, this.originalError, this.stackTrace});
  factory AppError.unknown([String message = 'Unknown error']) => AppError(message: message, code: 'UNKNOWN');
  factory AppError.network([String message = 'Network error']) => AppError(message: message, code: 'NETWORK');
  factory AppError.auth([String message = 'Auth error']) => AppError(message: message, code: 'AUTH');
  @override String toString() => 'AppError[$code]: $message';
}
