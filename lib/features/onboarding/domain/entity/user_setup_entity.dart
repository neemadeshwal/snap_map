import 'package:equatable/equatable.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';

class UserSetupEntity extends Equatable {
  final String userId;
  final String username;
  final String displayName;
  final List<String> interests;
  final String? profilePhoto;
  final String? profileLocalPath;
  final String? bio;
  final LocationEntity location;

  const UserSetupEntity({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.interests,
    this.profilePhoto,
    this.bio,
    required this.location,
    required this.profileLocalPath,
  });

  @override
  List<Object?> get props => [
    userId,
    username,
    displayName,
    interests,
    profilePhoto,
    bio,
    location,
  ];

  UserSetupEntity copyWith({
    String? userId,
    String? username,
    String? displayName,
    List<String>? interests,
    String? profilePhoto,
    String? bio,
    LocationEntity? location,
    String? profileLocalPath,
  }) {
    return UserSetupEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      interests: interests ?? this.interests,
      location: location ?? this.location,
      profileLocalPath: profileLocalPath ?? this.profileLocalPath,
    );
  }
}
