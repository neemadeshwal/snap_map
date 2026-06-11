import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';

class SaveUser implements Usecase<void, SaveUserSetupParams> {
  final UserSetupRepository repository;
  final FirebaseAuth auth;
  SaveUser(this.repository, this.auth);

  @override
  Future<Either<Failure, void>> call(SaveUserSetupParams params) async {
    final currentUser = auth.currentUser;

    // ← guard instead of !
    if (currentUser == null) {
      return Left(AuthFailure('User not logged in'));
    }
    final userSetup = UserSetupEntity(
      userId: auth.currentUser!.uid,
      username: params.username,
      displayName: params.displayName,
      bio: params.bio,
      profileLocalPath: params.profileLocalPath,
      interests: params.interests,
      location: params.location,
    );
    return await repository.saveUserSetup(userSetup: userSetup);
  }
}

class SaveUserSetupParams extends Equatable {
  final String username;
  final String displayName;
  final String? profileLocalPath;
  final String? bio;
  final List<String> interests;
  final LocationEntity location;

  const SaveUserSetupParams({
    required this.bio,
    required this.username,
    required this.displayName,
    required this.profileLocalPath,
    required this.interests,
    required this.location,
  });

  @override
  List<Object?> get props => [
    bio,
    username,
    displayName,
    profileLocalPath,
    interests,
    location,
  ];
}
