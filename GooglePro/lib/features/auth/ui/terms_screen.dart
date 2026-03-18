import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Terms of Service', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.close, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: const SingleChildScrollView(padding: EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Terms of Service', style: TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w700)),
        SizedBox(height: 16),
        Text('Last updated: January 1, 2025', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
        SizedBox(height: 20),
        Text('1. Acceptance of Terms', style: TextStyle(color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text('By using GooglePro, you agree to these terms. GooglePro is a remote device management application that enables screen sharing and control between trusted devices.', style: TextStyle(color: AppTheme.darkSubtext, height: 1.6)),
        SizedBox(height: 16),
        Text('2. Privacy & Data', style: TextStyle(color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text('All connections use end-to-end encrypted WebRTC. We do not store screen content. Device presence data is temporarily stored in Firebase to enable auto-connect features.', style: TextStyle(color: AppTheme.darkSubtext, height: 1.6)),
        SizedBox(height: 16),
        Text('3. Responsible Use', style: TextStyle(color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Text('Only connect to devices you own or have explicit permission to access. Unauthorized access to devices is prohibited and may be illegal.', style: TextStyle(color: AppTheme.darkSubtext, height: 1.6)),
      ])));
  }
}
