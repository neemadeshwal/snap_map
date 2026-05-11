abstract class AuthEvent {}

class SigninRequested extends AuthEvent {
  final String email;
  final String password;

  SigninRequested({required this.email, required this.password});
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignupRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}

class SigninWithGoogleRequested extends AuthEvent {}

class CheckAuthStatusRequested extends AuthEvent {}

class SignoutRequested extends AuthEvent {}

class ReauthenticateWithBiometricRequested extends AuthEvent {}

class SessionExpiredRequested extends AuthEvent {}

class ForgotPassRequested extends AuthEvent {
  final String email;
  ForgotPassRequested({required this.email});
}
