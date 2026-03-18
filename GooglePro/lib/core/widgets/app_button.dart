import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;

  const AppButton({super.key, required this.label, this.onPressed, this.isLoading = false, this.isOutlined = false, this.icon, this.backgroundColor, this.textColor, this.width, this.height = 52.0});

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppTheme.primaryColor;
    final fg = textColor ?? Colors.black;
    final child = isLoading
        ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: isOutlined ? bg : fg))
        : icon != null ? Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: isOutlined ? bg : fg, size: 18), const SizedBox(width: 8), Text(label, style: TextStyle(color: isOutlined ? bg : fg, fontWeight: FontWeight.w700, fontSize: 15))])
        : Text(label, style: TextStyle(color: isOutlined ? bg : fg, fontWeight: FontWeight.w700, fontSize: 15));

    if (isOutlined) {
      return SizedBox(width: width ?? double.infinity, height: height,
        child: OutlinedButton(onPressed: isLoading ? null : onPressed, style: OutlinedButton.styleFrom(side: BorderSide(color: bg), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: child));
    }
    return SizedBox(width: width ?? double.infinity, height: height,
      child: ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(backgroundColor: bg, foregroundColor: fg, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: child));
  }
}
