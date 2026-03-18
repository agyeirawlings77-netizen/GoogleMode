import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
class NetworkStatusBanner extends StatelessWidget {
  final bool isOnline;
  const NetworkStatusBanner({super.key, required this.isOnline});
  @override
  Widget build(BuildContext context) {
    if (isOnline) return const SizedBox.shrink();
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8), color: AppTheme.errorColor, child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.wifi_off, color: Colors.white, size: 16), SizedBox(width: 8), Text('No internet connection', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))])).animate().slideY(begin: -1, duration: 300.ms);
  }
}
