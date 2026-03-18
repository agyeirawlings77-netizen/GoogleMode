import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AddDeviceBottomSheet extends StatelessWidget {
  const AddDeviceBottomSheet({super.key});
  static Future<void> show(BuildContext context) => showModalBottomSheet(context: context, backgroundColor: AppTheme.darkCard, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))), builder: (_) => const AddDeviceBottomSheet());
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2))),
      const SizedBox(height: 20),
      const Text('Add Device', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 20),
      _option(Icons.qr_code_scanner, 'Scan QR Code', 'Pair by scanning QR from other device', () { Navigator.pop(context); context.push('/qr-pairing'); }),
      const SizedBox(height: 12),
      _option(Icons.share, 'Share My QR Code', 'Show my QR for another device to scan', () { Navigator.pop(context); context.push('/qr-pairing'); }),
    ]));
  }
  Widget _option(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), tileColor: AppTheme.darkSurface, onTap: onTap, leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: AppTheme.primaryColor, size: 22)), title: Text(title, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)), subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)));
  }
}
