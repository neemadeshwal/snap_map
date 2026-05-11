import 'package:dartz/dartz.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';

abstract class UserSetupRepository {
  Future<Either<Failure, void>> saveUserSetup({
    required UserSetupEntity userSetup,
  });
}
