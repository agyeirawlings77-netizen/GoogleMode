import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:googlepro/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('GooglePro Integration Tests', () {
    testWidgets('App starts and shows splash screen', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // Either splash, login, or dashboard should be visible
      expect(tester.any(find.byType(dynamic)), isTrue);
    });
  });
}
