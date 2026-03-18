mixin ErrorMixin {
  String? _errorMessage;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;

  void setError(String? message) { _errorMessage = message; }
  void clearError() { _errorMessage = null; }

  void handleError(dynamic error, {void Function(String)? onError}) {
    final message = error?.toString() ?? 'Unknown error';
    setError(message);
    onError?.call(message);
  }
}
