import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.signinWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("An unexpected error occured."));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await remoteDatasource.signupWithEmail(
        email: email,
        password: password,
        name: name,
      );
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("An unexpected error occured."));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDatasource.signout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure("An unexpected error occured"));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDatasource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("An unexpected error occured"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    try {
      final user = await remoteDatasource.signInWithGoogle();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("An expected error occured"));
    }
  }

  @override
  Future<Either<Failure, bool>> isBiometricAvailable() async {
    try {
      final result = await remoteDatasource.isBiometricAvailable();
      return Right(result);
    } catch (e) {
      return Left(AuthFailure('Biometric check failed'));
    }
  }

  @override
  Future<Either<Failure, bool>> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  }) async {
    try {
      final result = await remoteDatasource.authenticateWithBiometric(
        reason: reason,
        useDevicePasscode: useDevicePasscode,
      );
      return Right(result);
    } catch (e) {
      return Left(AuthFailure('Biometric authentication failed.'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      final result = await remoteDatasource.forgotPassword(email);
      return const Right(null);
    } catch (e) {
      print(e);
      return Left(AuthFailure("failed to reset password"));
    }
  }
}
