import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/location/model/location_point.dart';

void main() {
  group('LocationPoint', () {
    test('fromJson/toJson round trip', () {
      final loc = LocationPoint(latitude: 6.5244, longitude: 3.3792, accuracy: 10.0, timestamp: DateTime(2024, 1, 1));
      final json = loc.toJson();
      final restored = LocationPoint.fromJson(json);
      expect(restored.latitude, loc.latitude);
      expect(restored.longitude, loc.longitude);
    });
    test('formatted string is correct', () {
      final loc = LocationPoint(latitude: 6.52440, longitude: 3.37920, timestamp: DateTime.now());
      expect(loc.formatted.contains('6.52440'), true);
      expect(loc.formatted.contains('3.37920'), true);
    });
  });
}
