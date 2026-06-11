import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
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
    required super.profileLocalPath,
  });
  @override
  UserSetupModel copyWith({
    String? userId,
    String? username,
    String? displayName,
    List<String>? interests,
    String? profilePhoto,
    String? bio,
    LocationEntity? location,
    String? profileLocalPath,
  }) {
    return UserSetupModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      location: location ?? this.location,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      username: username ?? this.username,
      profileLocalPath: profileLocalPath ?? this.profileLocalPath,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'displayName': displayName,
    'bio': bio,
    'location': location.cityName,
    'profilePhoto': profilePhoto,
    'username': username,
    'interests': interests,
  };
}
