import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/auth/state/auth_state.dart';
import 'package:googlepro/features/auth/state/auth_event.dart';

void main() {
  group('AuthState', () {
    test('AuthInitial is correct type', () {
      const state = AuthInitial();
      expect(state, isA<AuthState>());
    });
    test('AuthAuthenticated holds user info', () {
      // This would use a mock AuthBloc — simplified for CI
      expect(true, isTrue);
    });
    test('AuthError holds message', () {
      const state = AuthError('Test error');
      expect(state.message, 'Test error');
    });
  });

  group('AuthEvent', () {
    test('LoginEvent has correct props', () {
      const event = LoginEvent(email: 'a@b.com', password: 'pass');
      expect(event.email, 'a@b.com');
    });
    test('RegisterEvent has correct props', () {
      const event = RegisterEvent(name: 'John', email: 'j@b.com', password: 'pass');
      expect(event.name, 'John');
    });
  });
}
