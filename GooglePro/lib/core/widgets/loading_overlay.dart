import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  const LoadingOverlay({super.key, required this.isLoading, required this.child, this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      if (isLoading) Container(color: Colors.black54, child: Center(child: Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16)), child: Column(mainAxisSize: MainAxisSize.min, children: [const CircularProgressIndicator(color: AppTheme.primaryColor), if (message != null) ...[const SizedBox(height: 16), Text(message!, style: const TextStyle(color: AppTheme.darkText, fontSize: 14))]]))))
    ]);
  }
}
