import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class WebRtcConnectingScreen extends StatelessWidget {
  final String deviceName;
  const WebRtcConnectingScreen({super.key, required this.deviceName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.primaryColor, width: 3))).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), duration: 1000.ms).then().scale(begin: const Offset(1.0, 1.0), end: const Offset(0.8, 0.8), duration: 1000.ms),
        const SizedBox(height: 24),
        Text('Connecting to $deviceName...', style: const TextStyle(color: AppTheme.darkText, fontSize: 16)),
        const SizedBox(height: 40),
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel', style: TextStyle(color: AppTheme.errorColor))),
      ])));
  }
}
