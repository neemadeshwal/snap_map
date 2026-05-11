import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
    super.displayName,
    super.phoneNumber,
    required super.createdAt,
    super.lastLoginAt,
  });

  // From firebase User

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? "",
      displayName: user.displayName,
      email: user.email ?? "",
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      phoneNumber: user.phoneNumber,
      lastLoginAt: user.metadata.lastSignInTime,
    );
  }
}
