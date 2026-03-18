class AuthResponse {
  final bool success;
  final String? token;
  final String? refreshToken;
  final AuthUser? user;
  final String? message;
  const AuthResponse({required this.success, this.token, this.refreshToken, this.user, this.message});
  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    success: json['success'] as bool? ?? false,
    token: json['token'] as String?,
    refreshToken: json['refreshToken'] as String?,
    user: json['user'] != null ? AuthUser.fromJson(json['user']) : null,
    message: json['message'] as String?,
  );
}
