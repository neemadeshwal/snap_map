import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/onboarding/data/datasources/user_setup_remote_datasource.dart';
import 'package:snapmap/features/onboarding/data/model/user_setup_model.dart';
import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class UserSetupRepositoryImpl implements UserSetupRepository {
  final UserSetupRemoteDatasource remoteDatasource;

  const UserSetupRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, void>> saveUserSetup({
    required UserSetupEntity userSetup,
  }) async {
    try {
      final model = UserSetupModel(
        userId: userSetup.userId,
        username: userSetup.username,
        displayName: userSetup.displayName,
        interests: userSetup.interests,
        profilePhoto: userSetup.profilePhoto,
        bio: userSetup.bio,
        location: userSetup.location,
      );
      await remoteDatasource.saveUserSetup(userSetup: model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
