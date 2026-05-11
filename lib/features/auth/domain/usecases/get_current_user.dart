import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUser implements Usecase<UserEntity?, NoParams> {
  final AuthRepository repository;

  const GetCurrentUser(this.repository);
  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
