import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/profile_state.dart';
import '../state/profile_event.dart';
import '../viewmodel/profile_bloc.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileBloc _bloc;
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = ProfileBloc()..add(const LoadProfileEvent());
  }

  @override void dispose() { _nameCtrl.dispose(); _phoneCtrl.dispose(); _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (ctx, state) {
          if (state is ProfileLoaded) { _nameCtrl.text = state.profile.displayName ?? ''; _phoneCtrl.text = state.profile.phone ?? ''; }
          if (state is ProfileSaved) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated'), backgroundColor: AppTheme.successColor));
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          appBar: AppBar(title: const Text('Profile', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
            actions: [IconButton(icon: const Icon(Icons.check, color: AppTheme.primaryColor), onPressed: _save)]),
          body: BlocBuilder<ProfileBloc, ProfileState>(builder: (ctx, state) {
            final user = FirebaseAuth.instance.currentUser;
            return ListView(padding: const EdgeInsets.all(24), children: [
              // Avatar
              Center(child: Stack(children: [
                CircleAvatar(radius: 52, backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL == null ? Text(user?.displayName?.isNotEmpty == true ? user!.displayName![0].toUpperCase() : 'U', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 36, fontWeight: FontWeight.w700)) : null),
                Positioned(bottom: 0, right: 0, child: Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor), child: const Icon(Icons.camera_alt, color: Colors.black, size: 16))),
              ])).animate().scale(delay: 100.ms),
              const SizedBox(height: 32),

              Form(key: _formKey, child: Column(children: [
                TextFormField(controller: _nameCtrl, style: const TextStyle(color: AppTheme.darkText), decoration: InputDecoration(labelText: 'Display Name', labelStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard, prefixIcon: const Icon(Icons.person_outline, color: AppTheme.darkSubtext), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)))),
                const SizedBox(height: 16),
                TextFormField(initialValue: user?.email, readOnly: true, style: const TextStyle(color: AppTheme.darkSubtext), decoration: InputDecoration(labelText: 'Email', labelStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard.withOpacity(0.5), prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.darkSubtext), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)))),
                const SizedBox(height: 16),
                TextFormField(controller: _phoneCtrl, style: const TextStyle(color: AppTheme.darkText), keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone Number', labelStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard, prefixIcon: const Icon(Icons.phone_outlined, color: AppTheme.darkSubtext), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)))),
              ])),
            ]);
          }),
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    _bloc.add(UpdateProfileEvent(displayName: _nameCtrl.text.trim(), phone: _phoneCtrl.text.trim()));
  }
}
