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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;

  @override void dispose() { _nameCtrl.dispose(); _emailCtrl.dispose(); _passCtrl.dispose(); _confirmCtrl.dispose(); super.dispose(); }

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
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
          body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 28), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Create Account', style: TextStyle(color: AppTheme.darkText, fontSize: 30, fontWeight: FontWeight.w800)).animate().fadeIn(),
            const SizedBox(height: 6),
            const Text('Join GooglePro to get started', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 32),

            _lbl('Full Name'),
            TextFormField(controller: _nameCtrl, textInputAction: TextInputAction.next, style: const TextStyle(color: AppTheme.darkText), validator: FormValidators.name, decoration: _dec('John Doe', Icons.person_outline)),
            const SizedBox(height: 16),
            _lbl('Email'),
            TextFormField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, style: const TextStyle(color: AppTheme.darkText), validator: FormValidators.email, decoration: _dec('john@example.com', Icons.email_outlined)),
            const SizedBox(height: 16),
            _lbl('Password'),
            TextFormField(controller: _passCtrl, obscureText: _obscurePass, textInputAction: TextInputAction.next, style: const TextStyle(color: AppTheme.darkText), validator: FormValidators.password, decoration: _dec('Min 8 chars', Icons.lock_outline, suffix: IconButton(icon: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppTheme.darkSubtext, size: 20), onPressed: () => setState(() => _obscurePass = !_obscurePass)))),
            const SizedBox(height: 16),
            _lbl('Confirm Password'),
            TextFormField(controller: _confirmCtrl, obscureText: true, textInputAction: TextInputAction.done, style: const TextStyle(color: AppTheme.darkText), validator: (v) => FormValidators.confirmPassword(v, _passCtrl.text), onFieldSubmitted: (_) => _submit(context), decoration: _dec('Repeat password', Icons.lock_outline)),
            const SizedBox(height: 28),

            BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
              return SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                onPressed: state is AuthLoading ? null : () => _submit(ctx),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: state is AuthLoading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ));
            }).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Already have an account?', style: TextStyle(color: AppTheme.darkSubtext)),
              TextButton(onPressed: () => context.pop(), child: const Text('Sign In', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 20),
          ])))),
        ),
      ),
    );
  }

  void _submit(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return;
    ctx.read<AuthBloc>().add(RegisterEvent(name: _nameCtrl.text.trim(), email: _emailCtrl.text.trim(), password: _passCtrl.text));
  }

  Widget _lbl(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13, fontWeight: FontWeight.w500)));
  InputDecoration _dec(String hint, IconData icon, {Widget? suffix}) => InputDecoration(hintText: hint, hintStyle: const TextStyle(color: AppTheme.darkSubtext), prefixIcon: Icon(icon, color: AppTheme.darkSubtext, size: 20), suffixIcon: suffix, filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)), errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.errorColor)));
}
