class BiometricData {
  final bool isAvailable;
  final bool isEnabled;
  final String? biometricType;
  const BiometricData({this.isAvailable = false, this.isEnabled = false, this.biometricType});
}
