import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SystemButtonsBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onRecents;
  final VoidCallback onVolumeUp;
  final VoidCallback onVolumeDown;
  final VoidCallback onScreenshot;

  const SystemButtonsBar({super.key, required this.onBack, required this.onHome, required this.onRecents, required this.onVolumeUp, required this.onVolumeDown, required this.onScreenshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.black.withOpacity(0.8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _btn(Icons.arrow_back, onBack, 'Back'),
        _btn(Icons.circle_outlined, onHome, 'Home'),
        _btn(Icons.crop_square_outlined, onRecents, 'Recent'),
        _divider(),
        _btn(Icons.volume_up, onVolumeUp, 'Vol+'),
        _btn(Icons.volume_down, onVolumeDown, 'Vol-'),
        _divider(),
        _btn(Icons.screenshot_monitor, onScreenshot, 'Shot'),
      ]),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap, String label) =>
    GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.white70, size: 22),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9)),
    ]));

  Widget _divider() => Container(width: 1, height: 28, color: Colors.white12);
}
