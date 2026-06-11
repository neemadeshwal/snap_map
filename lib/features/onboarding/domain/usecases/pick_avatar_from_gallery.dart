import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/onboarding/domain/entity/avatar_entity.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class PickAvatarFromGallery implements Usecase<AvatarEntity?, NoParams> {
  final UserSetupRepository repository;

  const PickAvatarFromGallery(this.repository);

  @override
  Future<Either<Failure, AvatarEntity?>> call(NoParams noparams) async {
    final result = await repository.pickFromGallery();
    return result.fold((failure) => Left(failure), (path) {
      if (path == null) return Right(null);
      return Right(
        AvatarEntity(
          imagePath: path,
          source: AvatarSourceType.gallery,
          isEmpty: false,
        ),
      );
    });
  }
}
