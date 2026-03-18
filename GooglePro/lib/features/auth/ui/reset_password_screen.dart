import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../validator/password_validator.dart';
import '../../../core/theme/app_theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;
  const ResetPasswordScreen({super.key, this.email});
  @override State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true, _obscureConfirm = true, _loading = false;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) { setState(() => _loading = false); context.go('/login'); }
    });
  }

  @override
  void dispose() { _passCtrl.dispose(); _confirmCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(24),
        child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          const Text('Reset Password', style: TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w700)).animate().fadeIn(),
          const SizedBox(height: 8),
          const Text('Create a new secure password', style: TextStyle(color: AppTheme.darkSubtext)).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 36),

          _label('New Password'),
          const SizedBox(height: 8),
          TextFormField(controller: _passCtrl, obscureText: _obscurePass, style: const TextStyle(color: AppTheme.darkText),
            decoration: _dec('Enter new password', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(icon: Icon(_obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppTheme.darkSubtext), onPressed: () => setState(() => _obscurePass = !_obscurePass))),
            validator: PasswordValidator.validate).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 20),
          _label('Confirm Password'),
          const SizedBox(height: 8),
          TextFormField(controller: _confirmCtrl, obscureText: _obscureConfirm, style: const TextStyle(color: AppTheme.darkText),
            decoration: _dec('Confirm new password', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppTheme.darkSubtext), onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm))),
            validator: (v) => PasswordValidator.validateConfirm(v, _passCtrl.text)).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 36),
          SizedBox(width: double.infinity, height: 54,
            child: ElevatedButton(onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: _loading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                  : const Text('Reset Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))).animate().fadeIn(delay: 400.ms),
        ])))),
    );
  }

  Widget _label(String t) => Text(t, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13, fontWeight: FontWeight.w500));

  InputDecoration _dec(String hint, IconData icon) => InputDecoration(
    hintText: hint, hintStyle: const TextStyle(color: AppTheme.darkSubtext),
    prefixIcon: Icon(icon, color: AppTheme.darkSubtext, size: 20),
    filled: true, fillColor: AppTheme.darkCard,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.errorColor)),
  );
}
