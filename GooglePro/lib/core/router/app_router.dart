import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/ui/splash_screen.dart';
import '../../features/auth/ui/welcome_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/register_screen.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/auth/ui/biometric_login_screen.dart';
import '../../features/auth/ui/terms_screen.dart';
import '../../features/dashboard/ui/dashboard_screen.dart';
import '../../features/device_management/ui/devices_screen.dart';
import '../../features/device_management/ui/device_detail_screen.dart';
import '../../features/device_management/ui/device_permissions_screen.dart';
import '../../features/qr_pairing/ui/qr_pairing_screen.dart';
import '../../features/trusted_device/ui/trusted_devices_screen.dart';
import '../../features/screen_capture/ui/screen_capture_screen.dart';
import '../../features/remote_control/ui/remote_control_screen.dart';
import '../../features/file_transfer/ui/file_transfer_screen.dart';
import '../../features/chat/ui/chat_screen.dart';
import '../../features/voice_call/ui/voice_call_screen.dart';
import '../../features/location/ui/location_screen.dart';
import '../../features/feedback/feedback_screen.dart';
import '../../features/device_management/model/device_model_local.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final pub = ['/login', '/register', '/forgot-password', '/welcome', '/biometric-login', '/terms', '/'];
      final user = FirebaseAuth.instance.currentUser;
      if (user == null && !pub.any((r) => loc.startsWith(r))) return '/login';
      if (user != null && (loc == '/login' || loc == '/register' || loc == '/welcome' || loc == '/')) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/',                      builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/welcome',               builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/login',                 builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register',              builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/forgot-password',       builder: (_, __) => const ForgotPasswordScreen()),
      GoRoute(path: '/biometric-login',       builder: (_, __) => const BiometricLoginScreen()),
      GoRoute(path: '/terms',                 builder: (_, __) => const TermsScreen()),
      GoRoute(path: '/dashboard',             builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/devices',               builder: (_, __) => const DevicesScreen()),
      GoRoute(path: '/device/:id',            builder: (_, s) => DeviceDetailScreen(device: s.extra as DeviceModelLocal)),
      GoRoute(path: '/permissions',           builder: (_, __) => const DevicePermissionsScreen()),
      GoRoute(path: '/qr-pairing',            builder: (_, __) => const QrPairingScreen()),
      GoRoute(path: '/trusted-devices',       builder: (_, __) => const TrustedDevicesScreen()),
      GoRoute(path: '/session/:deviceId',     builder: (_, s) => ScreenCaptureScreen(deviceId: s.pathParameters['deviceId']!)),
      GoRoute(path: '/remote-control/:id',    builder: (_, s) => RemoteControlScreen(deviceId: s.pathParameters['id']!)),
      GoRoute(path: '/file-transfer/:id',     builder: (_, s) => FileTransferScreen(deviceId: s.pathParameters['id']!)),
      GoRoute(path: '/chat/:id',              builder: (_, s) { final e = s.extra as Map<String,String>?; return ChatScreen(deviceId: s.pathParameters['id']!, deviceName: e?['name'] ?? ''); }),
      GoRoute(path: '/voice-call/:id',        builder: (_, s) { final e = s.extra as Map<String,String>?; return VoiceCallScreen(deviceId: s.pathParameters['id']!, deviceName: e?['name'] ?? ''); }),
      GoRoute(path: '/location/:id',          builder: (_, s) { final e = s.extra as Map<String,String>?; return LocationScreen(deviceId: s.pathParameters['id']!, deviceName: e?['name'] ?? ''); }),
      GoRoute(path: '/feedback',              builder: (_, __) => const FeedbackScreen()),
    ],
  );
}
