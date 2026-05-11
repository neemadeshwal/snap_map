import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, UserEntity>> signinWithGoogle();

  Future<Either<Failure, bool>> isBiometricAvailable();

  Future<Either<Failure, bool>> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  });

  Future<Either<Failure, void>> forgotPassword({required String email});
}
