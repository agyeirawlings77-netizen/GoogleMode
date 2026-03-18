import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:googlepro/domain/entities/user_entity.dart';
import 'package:googlepro/domain/repositories/i_auth_repository.dart';
import 'package:googlepro/domain/usecases/auth/register_use_case.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() { mockRepo = MockAuthRepository(); useCase = RegisterUseCase(mockRepo); });

  group('RegisterUseCase', () {
    test('should return UserEntity on successful registration', () async {
      const user = UserEntity(uid: 'uid123', email: 'new@test.com', displayName: 'New User');
      when(mockRepo.register(name: 'New User', email: 'new@test.com', password: 'Passw0rd!')).thenAnswer((_) async => const Right(user));
      final result = await useCase(name: 'New User', email: 'new@test.com', password: 'Passw0rd!');
      expect(result, const Right(user));
    });

    test('should return Left on duplicate email', () async {
      when(mockRepo.register(name: anyNamed('name'), email: anyNamed('email'), password: anyNamed('password'))).thenAnswer((_) async => const Left('Email already registered'));
      final result = await useCase(name: 'User', email: 'existing@test.com', password: 'Passw0rd!');
      expect(result.isLeft(), true);
    });
  });
}
