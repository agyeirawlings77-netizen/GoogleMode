abstract class IParentalRepository {
  Future<void> saveProfile(dynamic profile);
  Future<dynamic> getProfile(String deviceId);
  Future<void> blockApp(String profileId, String packageName);
  Future<void> unblockApp(String profileId, String packageName);
}
