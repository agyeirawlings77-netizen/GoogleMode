import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class TwoFactorSetupScreen extends StatelessWidget {
  const TwoFactorSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('2FA Setup', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        const Icon(Icons.security, color: AppTheme.primaryColor, size: 64),
        const SizedBox(height: 20),
        const Text('Two-Factor Authentication', style: TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        const Text('Add an extra layer of security by requiring a verification code when signing in.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, height: 1.6)),
        const Spacer(),
        SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Enable 2FA', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))),
      ])));
  }
}
