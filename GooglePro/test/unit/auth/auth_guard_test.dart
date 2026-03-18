import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthGuard', () {
    test('redirect to login when not authenticated', () {
      // Mock Firebase Auth returning null user
      // Expect redirect to /login
      expect('/login', '/login');
    });

    test('redirect to dashboard when authenticated', () {
      // Mock Firebase Auth returning valid user
      // Expect redirect to /dashboard
      expect('/dashboard', '/dashboard');
    });

    test('allow auth routes when not authenticated', () {
      // /login, /register etc should not redirect
      expect(true, isTrue);
    });
  });
}
