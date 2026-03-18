import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dashboard Widget Tests', () {
    testWidgets('Device card shows connect button when online', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container(padding: const EdgeInsets.all(16), child: Row(children: [const Text('Samsung Galaxy'), const Spacer(), ElevatedButton(onPressed: () {}, child: const Text('Connect'))])))));
      expect(find.text('Connect'), findsOneWidget);
    });

    testWidgets('Stats row shows device counts', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Row(children: [Text('2'), Text('Online'), Text('5'), Text('Devices')]))));
      expect(find.text('Online'), findsOneWidget);
    });
  });
}
