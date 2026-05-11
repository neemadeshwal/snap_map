import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class BiometricAuthenticate
    implements Usecase<bool, BiometricAuthenticateParams> {
  final AuthRepository repository;

  BiometricAuthenticate(this.repository);

  @override
  Future<Either<Failure, bool>> call(BiometricAuthenticateParams params) async {
    return repository.authenticateWithBiometric(
      reason: params.reason,
      useDevicePasscode: params.useDevicePasscode,
    );
  }
}

class BiometricAuthenticateParams extends Equatable {
  final String reason;
  final bool useDevicePasscode;

  const BiometricAuthenticateParams({
    required this.reason,
    required this.useDevicePasscode,
  });

  @override
  List<Object> get props => [reason, useDevicePasscode];
}
