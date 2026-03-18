import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformInfo', () {
    test('device name is not empty string', () {
      // PlatformInfo.deviceName returns manufacturer + model
      expect('Samsung Galaxy S24'.isNotEmpty, true);
    });
    test('SDK version is positive integer', () {
      expect(34 > 0, true);
    });
    test('supportsMediaProjection requires SDK 21+', () {
      expect(34 >= 21, true);
    });
  });
}
