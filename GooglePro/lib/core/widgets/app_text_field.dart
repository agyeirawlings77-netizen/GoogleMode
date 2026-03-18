import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const AppTextField({super.key, this.controller, this.hintText, this.labelText, this.prefixIcon, this.suffixIcon, this.obscureText = false, this.keyboardType = TextInputType.text, this.validator, this.onChanged, this.onTap, this.maxLines = 1, this.maxLength, this.readOnly = false, this.autofocus = false, this.textInputAction, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (labelText != null) ...[
        Text(labelText!, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
      ],
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        maxLines: maxLines,
        maxLength: maxLength,
        readOnly: readOnly,
        autofocus: autofocus,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        style: const TextStyle(color: AppTheme.darkText, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppTheme.darkSubtext),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppTheme.darkSubtext, size: 20) : null,
          suffixIcon: suffixIcon,
          filled: true, fillColor: AppTheme.darkCard,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.errorColor)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.errorColor, width: 2)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          counterText: '',
        ),
      ),
    ]);
  }
}
