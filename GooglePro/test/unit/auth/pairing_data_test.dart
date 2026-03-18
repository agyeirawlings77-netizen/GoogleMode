import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/qr_pairing/model/pairing_data.dart';

void main() {
  group('PairingData', () {
    test('toQrString/fromQrString round trip', () {
      final data = PairingData(deviceId: 'd1', deviceName: 'Test', ownerUid: 'uid1', timestamp: DateTime.now().millisecondsSinceEpoch);
      final str = data.toQrString();
      final restored = PairingData.fromQrString(str);
      expect(restored?.deviceId, data.deviceId);
      expect(restored?.ownerUid, data.ownerUid);
    });
    test('fresh data is not expired', () {
      final data = PairingData(deviceId: 'd1', deviceName: 'Test', ownerUid: 'uid1', timestamp: DateTime.now().millisecondsSinceEpoch);
      expect(data.isExpired, false);
    });
    test('old data is expired', () {
      final data = PairingData(deviceId: 'd1', deviceName: 'Test', ownerUid: 'uid1', timestamp: DateTime.now().subtract(const Duration(minutes: 10)).millisecondsSinceEpoch);
      expect(data.isExpired, true);
    });
    test('invalid JSON returns null', () {
      final result = PairingData.fromQrString('not valid json');
      expect(result, isNull);
    });
  });
}
