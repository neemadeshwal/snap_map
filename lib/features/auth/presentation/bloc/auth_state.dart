abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthSessionRefreshed extends AuthState {}

class SessionExpired extends AuthState {}

class BiometricLockedOut extends AuthState {}

class ForgotPassLinkSuccess extends AuthState {}
