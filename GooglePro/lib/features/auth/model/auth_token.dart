class AuthToken {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  const AuthToken({required this.accessToken, this.refreshToken, required this.expiresAt});
  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isExpiringSoon => DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 5)));
  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String?,
    expiresAt: DateTime.parse(json['expiresAt'] as String),
  );
  Map<String, dynamic> toJson() => {'accessToken': accessToken, 'refreshToken': refreshToken, 'expiresAt': expiresAt.toIso8601String()};
}
