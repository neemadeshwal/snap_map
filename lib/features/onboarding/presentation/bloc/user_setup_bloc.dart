import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/domain/usecases/check_username_available.dart';
import 'package:snapmap/features/onboarding/domain/usecases/get_current_location.dart';
import 'package:snapmap/features/onboarding/domain/usecases/pick_avatar_from_camera.dart';
import 'package:snapmap/features/onboarding/domain/usecases/pick_avatar_from_gallery.dart';
import 'package:snapmap/features/onboarding/domain/usecases/save_user.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_state.dart';
import 'package:stream_transform/stream_transform.dart';

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  final PickAvatarFromGallery pickAvatarFromGalleryUsecase;
  final PickAvatarFromCamera pickAvatarFromCameraUsecase;
  final SaveUser saveUserUsecase;
  final CheckUsernameAvailable checkUsernameAvailableUsecase;
  final GetCurrentLocation getCurrentLocationUsecase;
  UserSetupBloc({
    required this.pickAvatarFromGalleryUsecase,
    required this.pickAvatarFromCameraUsecase,
    required this.saveUserUsecase,
    required this.checkUsernameAvailableUsecase,
    required this.getCurrentLocationUsecase,
  }) : super(UserSetupState()) {
    on<AvatarPickFromGalleryRequested>(_onPickFromGalleryRequested);
    on<AvatarPickFromCameraRequested>(_onPickFromCameraRequested);
    on<AvatarRemoveRequested>(_onRemoveAvatar);
    on<SaveUserRequested>(_onSaveUser);
    on<UsernameChanged>(_onUsernameChanged, transformer: _debounce());
    on<GetLocationRequested>(_onGetLocation);
  }
  EventTransformer<UsernameChanged> _debounce() {
    return (events, mapper) =>
        events.debounce(const Duration(milliseconds: 600)).switchMap(mapper);
  }

  Future<void> _onPickFromGalleryRequested(
    AvatarPickFromGalleryRequested event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(isAvatarLoading: true));

    final result = await pickAvatarFromGalleryUsecase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(isAvatarLoading: false, errorMessage: failure.message),
      ),
      (avatar) {
        emit(state.copyWith(isAvatarLoading: false, avatar: avatar));
      },
    );
  }

  Future<void> _onPickFromCameraRequested(
    AvatarPickFromCameraRequested event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(isAvatarLoading: true));

    final result = await pickAvatarFromCameraUsecase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isAvatarLoading: false, errorMessage: failure.message),
      ),
      (avatar) async {
        emit(state.copyWith(isAvatarLoading: false, avatar: avatar));
      },
    );
  }

  Future<void> _onUsernameChanged(
    UsernameChanged event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(usernameStatus: UsernameStatus.checking));
    final result = await checkUsernameAvailableUsecase(event.username);
    result.fold(
      (failure) => emit(state.copyWith(usernameStatus: UsernameStatus.taken)),
      (isAvailable) => emit(
        state.copyWith(
          usernameStatus: isAvailable
              ? UsernameStatus.available
              : UsernameStatus.taken,
        ),
      ),
    );
  }

  Future<void> _onRemoveAvatar(
    AvatarRemoveRequested event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(clearAvatar: true));
  }

  Future<void> _onGetLocation(
    GetLocationRequested event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(isLocationLoading: true));

    final result = await getCurrentLocationUsecase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(isLocationLoading: false, errorMessage: failure.message),
      ),
      (location) =>
          emit(state.copyWith(isLocationLoading: false, location: location)),
    );
  }

  Future<void> _onSaveUser(
    SaveUserRequested event,
    Emitter<UserSetupState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));

    final result = await saveUserUsecase(
      SaveUserSetupParams(
        username: event.username,
        displayName: event.displayName,
        bio: event.bio,
        interests: event.interests,
        location: event.location,
        profileLocalPath: event.profileLocalPath,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isSaving: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isSaving: false, isSaved: true)),
    );
  }
}
