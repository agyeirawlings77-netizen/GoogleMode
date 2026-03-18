class ResetPasswordRequest {
  final String email;
  final String? otp;
  final String? newPassword;
  const ResetPasswordRequest({required this.email, this.otp, this.newPassword});
  Map<String, dynamic> toJson() => {'email': email, 'otp': otp, 'newPassword': newPassword};
}
