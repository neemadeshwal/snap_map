import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class ForgotPassword implements Usecase<void, ForgotPasswordParams> {
  final AuthRepository repository;
  ForgotPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    return await repository.forgotPassword(email: params.email);
  }
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}
