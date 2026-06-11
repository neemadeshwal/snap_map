import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class CheckUsernameAvailable implements Usecase<bool, String> {
  final UserSetupRepository repository;
  CheckUsernameAvailable(this.repository);

  @override
  Future<Either<Failure, bool>> call(String username) async {
    return await repository.isUsernameAvailable(username: username);
  }
}
