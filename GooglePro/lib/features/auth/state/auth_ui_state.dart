enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthUiStateModel {
  final AuthStatus status;
  final String? error;
  final String? userId;
  const AuthUiStateModel({this.status = AuthStatus.initial, this.error, this.userId});
  AuthUiStateModel copyWith({AuthStatus? status, String? error, String? userId}) =>
      AuthUiStateModel(status: status ?? this.status, error: error, userId: userId ?? this.userId);
  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;
}
