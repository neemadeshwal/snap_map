import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/onboarding/data/datasources/user_setup_local_datasource.dart';
import 'package:snapmap/features/onboarding/data/datasources/user_setup_remote_datasource.dart';
import 'package:snapmap/features/onboarding/data/model/user_setup_model.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class UserSetupRepositoryImpl implements UserSetupRepository {
  final UserSetupRemoteDatasource remoteDatasource;
  final UserSetupLocalDatasource localDatasource;

  const UserSetupRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });
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
        profileLocalPath: userSetup.profileLocalPath,
      );
      await remoteDatasource.saveUserSetup(userSetup: model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> pickFromCamera() async {
    try {
      final path = await localDatasource.pickFromCamera();
      return Right(path);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> pickFromGallery() async {
    try {
      final path = await localDatasource.pickFromGallery();
      return Right(path);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isUsernameAvailable({
    required String username,
  }) async {
    try {
      final result = await remoteDatasource.isUsernameAvailable(username);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      final result = await localDatasource.getCurrentLocation();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
