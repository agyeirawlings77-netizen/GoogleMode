import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/auth_state.dart';
import '../state/auth_event.dart';
import '../viewmodel/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final AuthBloc _bloc;
  final _otpCtrls = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _bloc = AuthBloc(getIt())..add(SendPhoneOtpEvent(widget.phone));
  }
  @override void dispose() { for (final c in _otpCtrls) c.dispose(); for (final f in _focusNodes) f.dispose(); _bloc.close(); super.dispose(); }

  String get _otp => _otpCtrls.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthAuthenticated) context.go('/dashboard');
          if (state is AuthOtpSent) { setState(() => _verificationId = state.verificationId); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP sent'), backgroundColor: AppTheme.successColor)); }
          if (state is AuthError) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
        },
        child: Scaffold(backgroundColor: AppTheme.darkBg,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
          body: Padding(padding: const EdgeInsets.all(28), child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(Icons.sms_outlined, color: AppTheme.primaryColor, size: 52).animate().scale(),
            const SizedBox(height: 20),
            const Text('Verify Phone', style: TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('Enter the 6-digit code sent to\n${widget.phone}', textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 15, height: 1.5)),
            const SizedBox(height: 36),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(6, (i) =>
              Container(width: 46, height: 56, margin: const EdgeInsets.symmetric(horizontal: 4),
                child: TextField(controller: _otpCtrls[i], focusNode: _focusNodes[i], textAlign: TextAlign.center, maxLength: 1, keyboardType: TextInputType.number, style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700), onChanged: (v) {
                  if (v.isNotEmpty && i < 5) FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                  if (v.isEmpty && i > 0) FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                  if (_otp.length == 6 && _verificationId != null) _bloc.add(VerifyOtpEvent(verificationId: _verificationId!, otp: _otp));
                },
                decoration: InputDecoration(counterText: '', filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)))))),
            ),
            const SizedBox(height: 32),
            BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
              return SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                onPressed: (state is AuthLoading || _verificationId == null) ? null : () { if (_otp.length == 6) _bloc.add(VerifyOtpEvent(verificationId: _verificationId!, otp: _otp)); },
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: state is AuthLoading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) : const Text('Verify', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ));
            }),
          ]))),
        ),
      ),
    );
  }
}
