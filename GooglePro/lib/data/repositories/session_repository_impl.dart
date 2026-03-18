import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../datasources/remote/session_remote_datasource.dart';
import '../datasources/local/session_local_datasource.dart';
import '../models/session_model.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/i_session_repository.dart';

@LazySingleton(as: ISessionRepository)
class SessionRepositoryImpl implements ISessionRepository {
  final SessionRemoteDatasource _remote;
  final SessionLocalDatasource _local;
  SessionRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<String, SessionEntity>> startSession({required String hostId, required String viewerId, required SessionType type}) async {
    try {
      final session = SessionModel(sessionId: const Uuid().v4(), hostId: hostId, viewerId: viewerId, type: type, status: SessionStatus.connecting, startedAt: DateTime.now());
      await _remote.createSession(session);
      return Right(session);
    } catch (e) { return Left(e.toString()); }
  }

  @override Future<Either<String, void>> endSession(String id) async { try { await _remote.endSession(id); return const Right(null); } catch (e) { return Left(e.toString()); } }
  @override Future<Either<String, void>> pauseSession(String id) async { try { await _remote.updateSessionStatus(id, SessionStatus.paused); return const Right(null); } catch (e) { return Left(e.toString()); } }
  @override Future<Either<String, void>> resumeSession(String id) async { try { await _remote.updateSessionStatus(id, SessionStatus.active); return const Right(null); } catch (e) { return Left(e.toString()); } }
  @override Future<List<SessionEntity>> getSessionHistory(String uid) => _remote.getHistory(uid);
  @override Stream<SessionEntity?> watchActiveSession(String uid) => _remote.watchActiveSession(uid);
}
