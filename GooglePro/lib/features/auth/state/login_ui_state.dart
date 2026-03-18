class LoginUiState {
  final bool isLoading;
  final String? error;
  final bool obscurePassword;
  final bool rememberMe;
  final String email;
  final String password;
  const LoginUiState({this.isLoading = false, this.error, this.obscurePassword = true, this.rememberMe = false, this.email = '', this.password = ''});
  LoginUiState copyWith({bool? isLoading, String? error, bool? obscurePassword, bool? rememberMe, String? email, String? password}) =>
    LoginUiState(isLoading: isLoading ?? this.isLoading, error: error, obscurePassword: obscurePassword ?? this.obscurePassword, rememberMe: rememberMe ?? this.rememberMe, email: email ?? this.email, password: password ?? this.password);
}
