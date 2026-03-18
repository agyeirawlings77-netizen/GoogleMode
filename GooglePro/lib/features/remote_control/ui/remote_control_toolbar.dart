import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class RemoteControlToolbar extends StatelessWidget {
  final bool touchEnabled;
  final bool keyboardVisible;
  final bool statsVisible;
  final VoidCallback onToggleTouch;
  final VoidCallback onToggleKeyboard;
  final VoidCallback onToggleStats;
  final VoidCallback onDisconnect;
  const RemoteControlToolbar({super.key, required this.touchEnabled, required this.keyboardVisible, required this.statsVisible, required this.onToggleTouch, required this.onToggleKeyboard, required this.onToggleStats, required this.onDisconnect});
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black87, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _btn(Icons.touch_app, touchEnabled, onToggleTouch, 'Touch'),
        _btn(Icons.keyboard, keyboardVisible, onToggleKeyboard, 'Keys'),
        _btn(Icons.bar_chart, statsVisible, onToggleStats, 'Stats'),
        _btn(Icons.call_end, true, onDisconnect, 'End', activeColor: AppTheme.errorColor),
      ]));
  }
  Widget _btn(IconData icon, bool active, VoidCallback onTap, String label, {Color activeColor = AppTheme.primaryColor}) {
    return GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: active ? activeColor : Colors.white38, size: 20),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(color: active ? activeColor : Colors.white38, fontSize: 9)),
    ]));
  }
}
