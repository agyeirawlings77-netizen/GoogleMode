import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VirtualKeyboard extends StatefulWidget {
  final void Function(String) onInput;
  final VoidCallback onClose;
  const VirtualKeyboard({super.key, required this.onInput, required this.onClose});
  @override State<VirtualKeyboard> createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  final _ctrl = TextEditingController();
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(color: AppTheme.darkCard, padding: const EdgeInsets.all(12),
      child: Row(children: [
        Expanded(child: TextField(controller: _ctrl, autofocus: true,
          style: const TextStyle(color: AppTheme.darkText),
          decoration: InputDecoration(hintText: 'Type to send...', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkSurface, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.darkBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.darkBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.primaryColor))),
          onSubmitted: (v) { if (v.isNotEmpty) { widget.onInput(v); _ctrl.clear(); } })),
        const SizedBox(width: 8),
        IconButton(icon: const Icon(Icons.send, color: AppTheme.primaryColor), onPressed: () { if (_ctrl.text.isNotEmpty) { widget.onInput(_ctrl.text); _ctrl.clear(); } }),
        IconButton(icon: const Icon(Icons.keyboard_hide, color: AppTheme.darkSubtext), onPressed: widget.onClose),
      ]));
  }
}
