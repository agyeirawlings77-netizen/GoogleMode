import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:googlepro/domain/entities/device_entity.dart';
import 'package:googlepro/domain/repositories/i_device_repository.dart';
import 'package:googlepro/domain/usecases/device/get_devices_use_case.dart';

class MockDeviceRepository extends Mock implements IDeviceRepository {}

void main() {
  late GetDevicesUseCase useCase;
  late MockDeviceRepository mockRepo;

  setUp(() { mockRepo = MockDeviceRepository(); useCase = GetDevicesUseCase(mockRepo); });

  group('GetDevicesUseCase', () {
    test('should return device list', () async {
      final devices = [const DeviceEntity(deviceId: 'd1', deviceName: 'Device 1', ownerUserId: 'uid1', status: DeviceStatus.online)];
      when(mockRepo.getDevices()).thenAnswer((_) async => Right(devices));
      final result = await useCase();
      expect(result.isRight(), true);
      result.fold((l) => fail('Should be Right'), (r) => expect(r.length, 1));
    });

    test('should return empty list when no devices', () async {
      when(mockRepo.getDevices()).thenAnswer((_) async => const Right([]));
      final result = await useCase();
      expect(result.isRight(), true);
      result.fold((l) => fail('Should be Right'), (r) => expect(r.isEmpty, true));
    });
  });
}
