import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class AiInputBar extends StatefulWidget {
  final void Function(String) onSend;
  const AiInputBar({super.key, required this.onSend});
  @override State<AiInputBar> createState() => _AiInputBarState();
}
class _AiInputBarState extends State<AiInputBar> {
  final _ctrl = TextEditingController();
  bool _hasText = false;
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  void _send() { if (_ctrl.text.trim().isEmpty) return; widget.onSend(_ctrl.text.trim()); _ctrl.clear(); setState(() => _hasText = false); }
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: TextField(controller: _ctrl, style: const TextStyle(color: AppTheme.darkText, fontSize: 14), onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty), onSubmitted: (_) => _send(), decoration: InputDecoration(hintText: 'Ask AI...', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
      const SizedBox(width: 8),
      GestureDetector(onTap: _hasText ? _send : null, child: Container(width: 42, height: 42, decoration: BoxDecoration(shape: BoxShape.circle, color: _hasText ? AppTheme.primaryColor : AppTheme.darkBorder), child: Icon(Icons.send_rounded, color: _hasText ? Colors.black : AppTheme.darkSubtext, size: 18))),
    ]);
  }
}
