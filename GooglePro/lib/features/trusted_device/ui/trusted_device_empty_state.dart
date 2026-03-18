import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class TrustedDeviceEmptyState extends StatelessWidget {
  final VoidCallback onAddDevice;
  const TrustedDeviceEmptyState({super.key, required this.onAddDevice});
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(0.1)), child: const Icon(Icons.devices, color: AppTheme.primaryColor, size: 56)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      const SizedBox(height: 24),
      const Text('No Trusted Devices', style: TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w700)).animate().fadeIn(delay: 200.ms),
      const SizedBox(height: 10),
      const Text('Add trusted devices to connect automatically without confirmation each time.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 14, height: 1.6)).animate().fadeIn(delay: 300.ms),
      const SizedBox(height: 32),
      ElevatedButton.icon(onPressed: onAddDevice, icon: const Icon(Icons.add, color: Colors.black), label: const Text('Add Device', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), minimumSize: const Size(200, 50))).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
    ])));
  }
}
