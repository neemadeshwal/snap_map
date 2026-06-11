import 'package:snapmap/features/onboarding/domain/entity/avatar_entity.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';

class UserSetupState {
  final AvatarEntity? avatar;
  final UsernameStatus usernameStatus;
  final bool isAvatarLoading;
  final bool isSaving;
  final bool isSaved;
  final String? errorMessage;
  final bool isLocationLoading; // ← add
  final LocationEntity? location;

  const UserSetupState({
    this.avatar,
    this.usernameStatus = UsernameStatus.idle,
    this.isSaved = false,
    this.isSaving = false,
    this.errorMessage,
    this.isAvatarLoading = false,
    this.isLocationLoading = false,
    this.location,
  });

  bool get hasAvatar => avatar != null && !(avatar!.isEmpty);

  UserSetupState copyWith({
    AvatarEntity? avatar,
    bool? isAvatarLoading,
    UsernameStatus? usernameStatus,
    bool? isSaving,
    bool? isSaved,
    String? errorMessage,
    bool clearAvatar = false,
    bool clearError = false,
    bool? isLocationLoading,
    LocationEntity? location,
  }) {
    return UserSetupState(
      avatar: clearAvatar ? null : avatar ?? this.avatar,
      isAvatarLoading: isAvatarLoading ?? this.isAvatarLoading,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      isLocationLoading: isLocationLoading ?? this.isLocationLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      location: location ?? this.location,
    );
  }
}

enum UsernameStatus { idle, checking, available, taken }

















// import 'package:snapmap/features/onboarding/domain/entity/avatar_entity.dart';

// abstract class UserSetupState {}

// class UserSetupSaving extends UserSetupState {}

// class UserSetupSaved extends UserSetupState {}

// class UserSetupError extends UserSetupState {
//   final String message;

//   UserSetupError({required this.message});
// }

// class AvatarInitial extends UserSetupState {}

// class AvatarLoading extends UserSetupState {}

// class AvatarError extends UserSetupState {
//   final String message;

//   AvatarError({required this.message});
// }

// class AvatarLoaded extends UserSetupState {
//   final AvatarEntity avatar;
//   AvatarLoaded(this.avatar);
// }

// class AvatarRemoved extends UserSetupState {}

// class UsernameAvailable extends UserSetupState {}

// class UsernameTaken extends UserSetupState {
//   final String message;

//   UsernameTaken({required this.message});
// }