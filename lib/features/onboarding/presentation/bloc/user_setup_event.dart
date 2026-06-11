import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';

abstract class UserSetupEvent {}

class AvatarPickFromGalleryRequested extends UserSetupEvent {}

class AvatarPickFromCameraRequested extends UserSetupEvent {}

class AvatarRemoveRequested extends UserSetupEvent {}

class SaveUserRequested extends UserSetupEvent {
  final String username;
  final String displayName;
  final String? profileLocalPath;
  final String? bio;
  final List<String> interests;
  final LocationEntity location;

  SaveUserRequested({
    required this.bio,
    required this.username,
    required this.displayName,
    required this.profileLocalPath,
    required this.interests,
    required this.location,
  });
}

class UsernameChanged extends UserSetupEvent {
  final String username;
  UsernameChanged(this.username);
}

class UsernameChecking extends UserSetupEvent {}

// 2. add event
final class GetLocationRequested extends UserSetupEvent {}
