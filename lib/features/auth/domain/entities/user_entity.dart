import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.lastLoginAt,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    name,
    phoneNumber,
    photoUrl,
    createdAt,
    lastLoginAt,
  ];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
