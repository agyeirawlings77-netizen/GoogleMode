import 'package:injectable/injectable.dart';
import '../datasource/session_remote_datasource.dart';
import '../model/session_model.dart';
import 'session_repository.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDatasource _remote;
  SessionRepositoryImpl(this._remote);
  @override Future<void> saveSession(SessionModel s) => _remote.saveSession(s);
  @override Future<void> endSession(String id) => _remote.endSession(id);
  @override Stream<List<SessionModel>> watchSessions(String uid) => _remote.watchSessions(uid);
}
