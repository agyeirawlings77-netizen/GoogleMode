import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:googlepro/domain/entities/user_entity.dart';
import 'package:googlepro/domain/repositories/i_auth_repository.dart';
import 'package:googlepro/domain/usecases/auth/login_use_case.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  const testUser = UserEntity(uid: 'uid123', email: 'test@test.com', displayName: 'Test User');

  group('LoginUseCase', () {
    test('should return UserEntity on successful login', () async {
      when(mockRepo.signInWithEmail('test@test.com', 'password123')).thenAnswer((_) async => const Right(testUser));
      final result = await useCase(email: 'test@test.com', password: 'password123');
      expect(result, const Right(testUser));
      verify(mockRepo.signInWithEmail('test@test.com', 'password123'));
      verifyNoMoreInteractions(mockRepo);
    });

    test('should return failure on wrong credentials', () async {
      when(mockRepo.signInWithEmail(any, any)).thenAnswer((_) async => const Left('Invalid credentials'));
      final result = await useCase(email: 'test@test.com', password: 'wrong');
      expect(result.isLeft(), true);
    });

    test('should return failure on empty email', () async {
      when(mockRepo.signInWithEmail('', any)).thenAnswer((_) async => const Left('Email is required'));
      final result = await useCase(email: '', password: 'password123');
      expect(result.isLeft(), true);
    });
  });
}
