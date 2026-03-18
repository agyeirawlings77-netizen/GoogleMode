import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/auto_connect/model/trusted_device.dart';
void main() {
  group('AutoConnectService', () {
    test('trusted device serializes correctly', () {
      final d = TrustedDevice(deviceId: 'd1', deviceName: 'Test', ownerUid: 'uid1', pairedAt: DateTime(2024));
      final json = d.toJson();
      final restored = TrustedDevice.fromJson(json);
      expect(restored.deviceId, d.deviceId);
    });
    test('copyWith updates autoConnect flag', () {
      final d = TrustedDevice(deviceId: 'd1', deviceName: 'Test', ownerUid: 'uid1', pairedAt: DateTime(2024));
      final d2 = d.copyWith(autoConnect: false);
      expect(d2.autoConnect, false);
      expect(d2.deviceId, d.deviceId);
    });
  });
}
