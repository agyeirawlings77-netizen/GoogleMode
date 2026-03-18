import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_theme.dart';
class SessionPermissionScreen extends StatefulWidget {
  const SessionPermissionScreen({super.key});
  @override State<SessionPermissionScreen> createState() => _SessionPermissionScreenState();
}
class _SessionPermissionScreenState extends State<SessionPermissionScreen> {
  Future<void> _requestAll() async {
    await [Permission.camera, Permission.microphone].request();
    if (mounted) context.go('/dashboard');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.video_camera_front_outlined, color: AppTheme.primaryColor, size: 64),
        const SizedBox(height: 24),
        const Text('Permissions Required', style: TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        const Text('GooglePro needs camera and microphone access for screen sharing sessions.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15, height: 1.6)),
        const SizedBox(height: 40),
        SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: _requestAll,
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: const Text('Grant Permissions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))),
      ]))));
  }
}
