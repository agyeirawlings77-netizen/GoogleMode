class TwoFactorData {
  final bool isEnabled;
  final String? secret;
  final List<String> backupCodes;
  const TwoFactorData({this.isEnabled = false, this.secret, this.backupCodes = const []});
}
