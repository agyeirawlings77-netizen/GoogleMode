import 'package:injectable/injectable.dart';
import '../service/app_lock_service.dart';
@injectable
class RemoveLockUsecase {
  final AppLockService _svc;
  RemoveLockUsecase(this._svc);
  Future<void> call() => _svc.removeLock();
}
