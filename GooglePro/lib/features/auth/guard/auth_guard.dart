import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGuard {
  static const _publicRoutes = ['/login', '/register', '/forgot-password', '/otp', '/welcome', '/biometric-login', '/terms', '/app-lock/pin', '/app-lock/biometric', '/onboarding'];

  static String? redirect(BuildContext context, GoRouterState state) {
    final loc = state.matchedLocation;
    final isPublic = _publicRoutes.any((r) => loc.startsWith(r));
    final user = FirebaseAuth.instance.currentUser;
    if (user == null && !isPublic && loc != '/') return '/login';
    if (user != null && (loc == '/login' || loc == '/register' || loc == '/welcome' || loc == '/')) return '/dashboard';
    return null;
  }
}
