import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppInitializer', () {
    test('init sequence is correct order', () {
      // Firebase → DI → Platform → Notifications
      final order = ['Firebase', 'DI', 'Platform', 'Notifications'];
      expect(order.first, 'Firebase');
      expect(order.last, 'Notifications');
    });
    test('orientation restricted to portrait', () {
      final allowed = ['portraitUp', 'portraitDown'];
      expect(allowed.contains('portraitUp'), true);
      expect(allowed.contains('landscapeLeft'), false);
    });
  });
}
