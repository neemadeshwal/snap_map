import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class SignUpWithEmail implements Usecase<UserEntity, SignupParams> {
  final AuthRepository repository;
  SignUpWithEmail(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignupParams params) async {
    return await repository.signUpWithEmail(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignupParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}
