import 'package:snapmap/features/onboarding/domain/entity/user_setup_entity.dart';

class UserSetupModel extends UserSetupEntity {
  const UserSetupModel({
    required super.userId,
    required super.displayName,
    required super.bio,
    required super.interests,
    required super.location,
    required super.profilePhoto,
    required super.username,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'displayName': displayName,
    'bio': bio,
    'location': location,
    'profilePhoto': profilePhoto,
    'username': username,
    'interests': interests,
  };
}
