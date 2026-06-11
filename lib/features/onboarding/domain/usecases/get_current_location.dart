import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class GetCurrentLocation implements Usecase<LocationEntity, NoParams> {
  final UserSetupRepository repository;

  GetCurrentLocation(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(NoParams noparams) async {
    final result = await repository.getCurrentLocation();

    return result.fold((failure) => Left(failure), (value) {
      return Right(
        LocationEntity(
          cityName: value.cityName,
          latitude: value.latitude,
          longitude: value.longitude,
        ),
      );
    });
  }
}
