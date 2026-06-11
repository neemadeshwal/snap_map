import 'package:snapmap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:snapmap/features/auth/data/models/user_model.dart';

class FakeAuthDatasource implements AuthRemoteDatasource {
  bool shouldThrowError = false;

  @override
  Future<UserModel> signinWithEmail({
    required String email,
    required String password,
  }) async {
    if (shouldThrowError) throw Exception("Sign in failed");

    return UserModel(
      uid: 'user123',
      name: 'Test User',
      email: email,
      phoneNumber: null,
      photoUrl: null,
      createdAt: DateTime(2024, 1, 1),
      lastLoginAt: null,
    );
  }

  @override
  Future<UserModel> signupWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    if (shouldThrowError) throw Exception("Sign up failed");

    return UserModel(
      uid: 'user123',
      name: name,
      email: email,
      phoneNumber: null,
      photoUrl: null,
      createdAt: DateTime(2024, 1, 1),
      lastLoginAt: null,
    );
  }

  @override
  Future<void> signout() async {
    if (shouldThrowError) throw Exception("Sign out failed");
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    if (shouldThrowError) throw Exception("Get current user");

    return UserModel(
      uid: 'user123',
      name: 'Test User',
      email: 'test@example.com',
      phoneNumber: null,
      photoUrl: null,
      createdAt: DateTime(2024, 1, 1),
      lastLoginAt: null,
    );
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    if (shouldThrowError) throw Exception("Google sign in failed");

    return UserModel(
      uid: 'google123',
      name: 'Google User',
      email: 'google@gmail.com',
      phoneNumber: null,
      photoUrl: null,
      createdAt: DateTime.now(),
      lastLoginAt: null,
    );
  }

  @override
  Future<bool> isBiometricAvailable() async {
    if (shouldThrowError) throw Exception("Biometric check failed");
    return Future.value(true);
  }

  @override
  Future<bool> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  }) async {
    if (shouldThrowError) throw Exception("Biometric auth failed");
    return true;
  }

  @override
  Future<void> forgotPassword(String email) async {
    if (shouldThrowError) throw Exception("Forgot password failed");
  }
}
