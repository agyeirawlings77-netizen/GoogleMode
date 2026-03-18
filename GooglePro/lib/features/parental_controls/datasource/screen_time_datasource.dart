import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../model/screen_time_model.dart';
@singleton
class ScreenTimeDatasource {
  final _db = FirebaseDatabase.instance;
  Future<List<ScreenTimeModel>> getWeekHistory(String deviceId) async {
    final models = <ScreenTimeModel>[];
    for (int i = 0; i < 7; i++) {
      final day = DateTime.now().subtract(Duration(days: i)).toIso8601String().substring(0, 10);
      try {
        final snap = await _db.ref('screen_time/$deviceId/$day').get();
        if (snap.exists) models.add(ScreenTimeModel.fromJson(Map<String, dynamic>.from(snap.value as Map)));
        else models.add(ScreenTimeModel(deviceId: deviceId, date: DateTime.now().subtract(Duration(days: i)), totalMinutes: 0, appUsageMinutes: {}));
      } catch (_) {}
    }
    return models;
  }
}
