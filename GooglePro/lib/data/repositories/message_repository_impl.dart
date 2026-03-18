import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../datasources/remote/message_remote_datasource.dart';
import '../datasources/local/message_local_datasource.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/i_message_repository.dart';

@LazySingleton(as: IMessageRepository)
class MessageRepositoryImpl implements IMessageRepository {
  final MessageRemoteDatasource _remote;
  final MessageLocalDatasource _local;
  MessageRepositoryImpl(this._remote, this._local);

  String get _name => FirebaseAuth.instance.currentUser?.displayName ?? 'Me';

  @override Future<Either<String, void>> sendMessage({required String sessionId, required String text, required String senderId, required String senderName}) async {
    try { await _remote.sendMessage(sessionId, text, senderName.isNotEmpty ? senderName : _name); return const Right(null); }
    catch (e) { return Left(e.toString()); }
  }
  @override Future<Either<String, List<MessageEntity>>> getMessages(String sessionId, {int limit = 50}) async {
    try { return Right(await _remote.getMessages(sessionId, limit: limit)); }
    catch (_) { return Right(_local.load(sessionId)); }
  }
  @override Stream<List<MessageEntity>> watchMessages(String sessionId) => _remote.watchMessages(sessionId);
  @override Future<Either<String, void>> markRead(String sessionId, String userId) async => const Right(null);
  @override Future<Either<String, void>> deleteMessage(String sessionId, String messageId) async => const Right(null);
}
