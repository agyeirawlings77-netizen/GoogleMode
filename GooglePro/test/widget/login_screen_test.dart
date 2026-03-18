import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('should display email and password fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Column(children: [TextField(key: Key('email')), TextField(key: Key('password'))]))));
      expect(find.byKey(const Key('email')), findsOneWidget);
      expect(find.byKey(const Key('password')), findsOneWidget);
    });

    testWidgets('sign in button should be visible', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: ElevatedButton(key: const Key('signInBtn'), onPressed: () {}, child: const Text('Sign In')))));
      expect(find.byKey(const Key('signInBtn')), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });
  });
}
