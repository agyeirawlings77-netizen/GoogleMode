import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/auto_connect/model/trusted_device.dart';

void main() {
  group('TrustedDevice', () {
    final device = TrustedDevice(deviceId: 'd1', deviceName: 'Test Device', ownerUid: 'uid1', pairedAt: DateTime(2024, 1, 1));

    test('toJson/fromJson round trip', () {
      final json = device.toJson();
      final restored = TrustedDevice.fromJson(json);
      expect(restored.deviceId, device.deviceId);
      expect(restored.deviceName, device.deviceName);
      expect(restored.ownerUid, device.ownerUid);
      expect(restored.autoConnect, true);
    });
    test('copyWith changes only specified fields', () {
      final updated = device.copyWith(deviceName: 'New Name');
      expect(updated.deviceName, 'New Name');
      expect(updated.deviceId, device.deviceId);
      expect(updated.ownerUid, device.ownerUid);
    });
  });
}
