import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class PullToRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const PullToRefresh({super.key, required this.child, required this.onRefresh});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, color: AppTheme.primaryColor, backgroundColor: AppTheme.darkCard, child: child);
  }
}
