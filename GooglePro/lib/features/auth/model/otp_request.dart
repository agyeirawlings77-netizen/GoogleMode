class OtpRequest {
  final String phone;
  final String otp;
  final String? verificationId;
  const OtpRequest({required this.phone, required this.otp, this.verificationId});
  Map<String, dynamic> toJson() => {'phone': phone, 'otp': otp, 'verificationId': verificationId};
}
