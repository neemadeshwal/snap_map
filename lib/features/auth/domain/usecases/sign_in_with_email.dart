import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class SignInWithEmail implements Usecase<UserEntity, SigninParams> {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SigninParams params) async {
    return await repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class SigninParams extends Equatable {
  final String email;
  final String password;

  const SigninParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
