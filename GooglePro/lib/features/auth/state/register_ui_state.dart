class RegisterUiState {
  final bool isLoading;
  final String? error;
  final bool obscurePassword;
  final bool obscureConfirm;
  const RegisterUiState({this.isLoading = false, this.error, this.obscurePassword = true, this.obscureConfirm = true});
  RegisterUiState copyWith({bool? isLoading, String? error, bool? obscurePassword, bool? obscureConfirm}) =>
    RegisterUiState(isLoading: isLoading ?? this.isLoading, error: error, obscurePassword: obscurePassword ?? this.obscurePassword, obscureConfirm: obscureConfirm ?? this.obscureConfirm);
}
