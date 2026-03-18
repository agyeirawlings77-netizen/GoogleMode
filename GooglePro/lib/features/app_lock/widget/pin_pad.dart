import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PinPad extends StatelessWidget {
  final String enteredPin;
  final int pinLength;
  final void Function(String) onDigit;
  final VoidCallback onDelete;
  final VoidCallback? onBiometric;
  const PinPad({super.key, required this.enteredPin, this.pinLength = 4, required this.onDigit, required this.onDelete, this.onBiometric});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(pinLength, (i) =>
        Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 14, height: 14,
          decoration: BoxDecoration(shape: BoxShape.circle, color: i < enteredPin.length ? AppTheme.primaryColor : AppTheme.darkBorder)))),
      const SizedBox(height: 32),
      ...[[1, 2, 3], [4, 5, 6], [7, 8, 9]].map((row) => Padding(padding: const EdgeInsets.only(bottom: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: row.map((d) => _DigitBtn(digit: d, onTap: () => onDigit('$d'))).toList()))),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        onBiometric != null ? _ActionBtn(icon: Icons.fingerprint, onTap: onBiometric!) : const SizedBox(width: 72, height: 72),
        _DigitBtn(digit: 0, onTap: () => onDigit('0')),
        _ActionBtn(icon: Icons.backspace_outlined, onTap: onDelete),
      ]),
    ]);
  }
}
class _DigitBtn extends StatelessWidget {
  final int digit; final VoidCallback onTap;
  const _DigitBtn({required this.digit, required this.onTap});
  @override Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(width: 72, height: 72, margin: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.darkCard, border: Border.all(color: AppTheme.darkBorder)), child: Center(child: Text('$digit', style: const TextStyle(color: AppTheme.darkText, fontSize: 26, fontWeight: FontWeight.w400)))));
}
class _ActionBtn extends StatelessWidget {
  final IconData icon; final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.onTap});
  @override Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: SizedBox(width: 72, height: 72, child: Center(child: Icon(icon, color: AppTheme.darkSubtext, size: 26))));
}
