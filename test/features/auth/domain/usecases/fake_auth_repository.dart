import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  bool shouldThrowError = false;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (shouldThrowError) {
      return Left(AuthFailure('Sign in failed'));
    }

    return Right(
      UserEntity(
        uid: 'user123',
        name: 'Test User',
        email: email,
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime(2024, 1, 1),
        lastLoginAt: null,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    if (shouldThrowError) {
      return Left(AuthFailure('Sign up failed'));
    }

    return Right(
      UserEntity(
        uid: 'user123',
        name: name,
        email: email,
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime.now(),
        lastLoginAt: null,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (shouldThrowError) {
      return Left(AuthFailure('Sign out failed'));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    if (shouldThrowError) {
      return Left(AuthFailure('Get current user failed'));
    }

    return Right(
      UserEntity(
        uid: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime(2024, 1, 1),
        lastLoginAt: null,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    if (shouldThrowError) {
      return Left(AuthFailure('Google sign in failed'));
    }

    return Right(
      UserEntity(
        uid: 'google123',
        name: 'Google User',
        email: 'google@gmail.com',
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime.now(),
        lastLoginAt: null,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> isBiometricAvailable() async {
    if (shouldThrowError) {
      return Left(AuthFailure('Biometric check failed'));
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  }) async {
    if (shouldThrowError) {
      return Left(AuthFailure('Biometric auth failed'));
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    if (shouldThrowError) {
      return Left(AuthFailure('Forgot password failed'));
    }
    return const Right(null);
  }
}
