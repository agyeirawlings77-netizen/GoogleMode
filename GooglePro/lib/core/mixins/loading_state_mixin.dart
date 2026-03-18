import 'package:flutter/material.dart';

mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    if (mounted) setState(() => _isLoading = loading);
  }

  Future<void> withLoading(Future<void> Function() fn) async {
    setLoading(true);
    try { await fn(); }
    finally { setLoading(false); }
  }
}
