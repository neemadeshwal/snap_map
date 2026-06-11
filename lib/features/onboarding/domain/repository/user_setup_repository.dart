import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';

abstract class UserSetupRepository {
  Future<Either<Failure, void>> saveUserSetup({
    required UserSetupEntity userSetup,
  });

  Future<Either<Failure, String?>> pickFromCamera();
  Future<Either<Failure, String?>> pickFromGallery();
  Future<Either<Failure, bool>> isUsernameAvailable({required String username});
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
}
