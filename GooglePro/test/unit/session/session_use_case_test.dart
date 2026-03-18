import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:googlepro/domain/entities/session_entity.dart';
import 'package:googlepro/domain/repositories/i_session_repository.dart';
import 'package:googlepro/domain/usecases/session/start_session_use_case.dart';
import 'package:googlepro/domain/usecases/session/end_session_use_case.dart';

class MockSessionRepository extends Mock implements ISessionRepository {}

void main() {
  late StartSessionUseCase startUseCase;
  late EndSessionUseCase endUseCase;
  late MockSessionRepository mockRepo;

  setUp(() { mockRepo = MockSessionRepository(); startUseCase = StartSessionUseCase(mockRepo); endUseCase = EndSessionUseCase(mockRepo); });

  final testSession = SessionEntity(sessionId: 's1', hostId: 'host1', viewerId: 'viewer1', type: SessionType.screenShare, status: SessionStatus.active, startedAt: DateTime.now());

  group('StartSessionUseCase', () {
    test('should return session on success', () async {
      when(mockRepo.startSession(hostId: 'host1', viewerId: 'viewer1', type: SessionType.screenShare)).thenAnswer((_) async => Right(testSession));
      final result = await startUseCase(hostId: 'host1', viewerId: 'viewer1', type: SessionType.screenShare);
      expect(result.isRight(), true);
    });
  });

  group('EndSessionUseCase', () {
    test('should end session successfully', () async {
      when(mockRepo.endSession('s1')).thenAnswer((_) async => const Right(null));
      final result = await endUseCase('s1');
      expect(result.isRight(), true);
    });
  });
}
