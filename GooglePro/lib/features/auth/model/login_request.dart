class LoginRequest {
  final String email;
  final String password;
  final bool rememberMe;
  const LoginRequest({required this.email, required this.password, this.rememberMe = false});
  Map<String, dynamic> toJson() => {'email': email, 'password': password, 'rememberMe': rememberMe};
}
