mixin LoadingMixin {
  bool _isLoading = false;
  String? _loadingMessage;

  bool get isLoading => _isLoading;
  String? get loadingMessage => _loadingMessage;

  void setLoading(bool loading, {String? message}) {
    _isLoading = loading;
    _loadingMessage = message;
  }

  Future<T> withLoading<T>(Future<T> Function() action, {String? message}) async {
    setLoading(true, message: message);
    try { return await action(); }
    finally { setLoading(false); }
  }
}
