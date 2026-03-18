import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override List<Object?> get props => [message];
  @override String toString() => '$runtimeType: $message';
}

class NetworkFailure extends Failure { const NetworkFailure([super.message = 'Network error. Check your connection.']); }
class ServerFailure extends Failure { const ServerFailure([super.message = 'Server error. Please try again.']); }
class CacheFailure extends Failure { const CacheFailure([super.message = 'Cache error']); }
class AuthFailure extends Failure { const AuthFailure([super.message = 'Authentication failed']); }
class PermissionFailure extends Failure { const PermissionFailure([super.message = 'Permission denied']); }
class ValidationFailure extends Failure { const ValidationFailure([super.message = 'Validation error']); }
class NotFoundFailure extends Failure { const NotFoundFailure([super.message = 'Not found']); }
class TimeoutFailure extends Failure { const TimeoutFailure([super.message = 'Request timed out']); }
class UnknownFailure extends Failure { const UnknownFailure([super.message = 'Unknown error']); }
class WebRtcFailure extends Failure { const WebRtcFailure([super.message = 'Connection failed']); }
class FileFailure extends Failure { const FileFailure([super.message = 'File operation failed']); }
class SignalingFailure extends Failure { const SignalingFailure([super.message = 'Signaling error']); }
