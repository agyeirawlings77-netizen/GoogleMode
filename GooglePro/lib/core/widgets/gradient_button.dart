import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final List<Color> colors;
  final IconData? icon;
  const GradientButton({super.key, required this.label, this.onPressed, this.isLoading = false, this.height = 52, this.colors = const [AppTheme.primaryColor, AppTheme.accentColor], this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: colors.first.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: isLoading
            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (icon != null) ...[Icon(icon, color: Colors.black, size: 18), const SizedBox(width: 8)],
                Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
              ]),
        ),
      ));
  }
}
