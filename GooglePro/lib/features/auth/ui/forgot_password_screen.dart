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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  @override void dispose() { _emailCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(getIt()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthEmailSent) {
            showDialog(context: context, builder: (_) => AlertDialog(backgroundColor: AppTheme.darkCard, title: const Text('Email Sent', style: TextStyle(color: AppTheme.darkText)), content: Text('Password reset link sent to ${_emailCtrl.text}', style: const TextStyle(color: AppTheme.darkSubtext)), actions: [TextButton(onPressed: () { Navigator.pop(context); context.pop(); }, child: const Text('OK', style: TextStyle(color: AppTheme.primaryColor)))]));
          }
          if (state is AuthError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
          body: Padding(padding: const EdgeInsets.all(28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.lock_reset, color: AppTheme.primaryColor, size: 52).animate().scale(),
            const SizedBox(height: 20),
            const Text('Forgot Password?', style: TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Enter your email and we\'ll send a reset link.', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15, height: 1.5)),
            const SizedBox(height: 32),
            Form(key: _formKey, child: TextFormField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, style: const TextStyle(color: AppTheme.darkText), validator: FormValidators.email, decoration: InputDecoration(hintText: 'Your email address', hintStyle: const TextStyle(color: AppTheme.darkSubtext), prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.darkSubtext, size: 20), filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2))))),
            const SizedBox(height: 24),
            BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
              return SizedBox(width: double.infinity, height: 54, child: ElevatedButton(onPressed: state is AuthLoading ? null : () { if (_formKey.currentState!.validate()) ctx.read<AuthBloc>().add(ForgotPasswordEvent(_emailCtrl.text.trim())); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: state is AuthLoading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) : const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))));
            }),
          ])),
        ),
      ),
    );
  }
}
