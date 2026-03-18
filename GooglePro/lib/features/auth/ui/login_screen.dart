import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/auth_state.dart';
import '../state/auth_event.dart';
import '../viewmodel/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/validators/form_validators.dart';
import '../../../core/di/injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;

  @override void dispose() { _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(getIt()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthAuthenticated) context.go('/dashboard');
          if (state is AuthError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(28), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 40),
            const Text('Welcome back', style: TextStyle(color: AppTheme.darkText, fontSize: 30, fontWeight: FontWeight.w800)).animate().fadeIn(),
            const SizedBox(height: 6),
            const Text('Sign in to continue', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 40),

            _buildLabel('Email'),
            TextFormField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, style: const TextStyle(color: AppTheme.darkText), validator: FormValidators.email, decoration: _inputDecor('Enter your email', Icons.email_outlined)),
            const SizedBox(height: 16),

            _buildLabel('Password'),
            TextFormField(controller: _passCtrl, obscureText: _obscurePass, textInputAction: TextInputAction.done, style: const TextStyle(color: AppTheme.darkText), validator: (v) => v?.isEmpty == true ? 'Password is required' : null, onFieldSubmitted: (_) => _submit(context), decoration: _inputDecor('Enter password', Icons.lock_outline, suffix: IconButton(icon: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppTheme.darkSubtext, size: 20), onPressed: () => setState(() => _obscurePass = !_obscurePass)))),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => context.push('/forgot-password'), child: const Text('Forgot password?', style: TextStyle(color: AppTheme.primaryColor)))),
            const SizedBox(height: 8),

            BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
              return SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                onPressed: state is AuthLoading ? null : () => _submit(ctx),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: state is AuthLoading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ));
            }).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 54, child: OutlinedButton.icon(
              onPressed: () => context.push('/biometric-login'),
              icon: const Icon(Icons.fingerprint, color: AppTheme.primaryColor),
              label: const Text('Use Biometric', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.darkBorder), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            )).animate().fadeIn(delay: 350.ms),

            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account?", style: TextStyle(color: AppTheme.darkSubtext)),
              TextButton(onPressed: () => context.push('/register'), child: const Text('Sign Up', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700))),
            ]).animate().fadeIn(delay: 400.ms),
          ])))),
        ),
      ),
    );
  }

  void _submit(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return;
    ctx.read<AuthBloc>().add(LoginEvent(email: _emailCtrl.text.trim(), password: _passCtrl.text));
  }

  Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13, fontWeight: FontWeight.w500)));

  InputDecoration _inputDecor(String hint, IconData icon, {Widget? suffix}) => InputDecoration(hintText: hint, hintStyle: const TextStyle(color: AppTheme.darkSubtext), prefixIcon: Icon(icon, color: AppTheme.darkSubtext, size: 20), suffixIcon: suffix, filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)), errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.errorColor)));
}
