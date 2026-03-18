import 'package:injectable/injectable.dart';
import '../model/screen_time_stats.dart';
import '../repository/parental_repository.dart';
@injectable
class GetScreenTimeUsecase {
  final ParentalRepository _repo;
  GetScreenTimeUsecase(this._repo);
  Future<ScreenTimeStats> call(String deviceId) => _repo.getScreenTimeStats(deviceId);
}
