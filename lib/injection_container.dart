import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:snapmap/features/auth/data/repository/auth_repository_impl.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';
import 'package:snapmap/features/auth/domain/usecases/biometric_authenticate.dart';
import 'package:snapmap/features/auth/domain/usecases/forgot_password.dart';
import 'package:snapmap/features/auth/domain/usecases/get_current_user.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_out.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:snapmap/features/onboarding/data/datasources/user_setup_local_datasource.dart';
import 'package:snapmap/features/onboarding/data/datasources/user_setup_remote_datasource.dart';
import 'package:snapmap/features/onboarding/data/repository/user_setup_repository_impl.dart';
import 'package:snapmap/features/onboarding/domain/repository/user_setup_repository.dart';
import 'package:snapmap/features/onboarding/domain/usecases/check_username_available.dart';
import 'package:snapmap/features/onboarding/domain/usecases/get_current_location.dart';
import 'package:snapmap/features/onboarding/domain/usecases/pick_avatar_from_camera.dart';
import 'package:snapmap/features/onboarding/domain/usecases/pick_avatar_from_gallery.dart';
import 'package:snapmap/features/onboarding/domain/usecases/save_user.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ==== app life cycle manager ===========
  // firebase instance

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => LocalAuthentication());
  sl.registerLazySingleton(() => ImagePicker());
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  sl.registerSingleton<AppLifecycleManager>(AppLifecycleManager());
  // auth-bloc

  // auth use cases

  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => BiometricAuthenticate(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  sl.registerLazySingleton(() => PickAvatarFromCamera(sl()));
  sl.registerLazySingleton(() => PickAvatarFromGallery(sl()));
  sl.registerLazySingleton(() => SaveUser(sl(), sl()));
  sl.registerLazySingleton(() => CheckUsernameAvailable(sl()));
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // auth repo

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: sl()),
  );
  sl.registerLazySingleton<UserSetupRepository>(
    () =>
        UserSetupRepositoryImpl(remoteDatasource: sl(), localDatasource: sl()),
  );

  // auth data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
      localAuth: sl(),
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<UserSetupRemoteDatasource>(
    () => UserSetupRemoteDatasourcesImpl(firestore: sl(), auth: sl()),
  );
  sl.registerLazySingleton<UserSetupLocalDatasource>(
    () => UserSetupLocalDatasourcesImpl(imagePicker: sl()),
  );
  sl.registerSingleton<AuthBloc>(
    AuthBloc(
      signInUsecase: sl(),
      signOutUsecase: sl(),
      signUpUsecase: sl(),
      getCurrentUserUsecase: sl(),
      signInWithGoogleUsecase: sl(),
      appLifecycleManager: sl(),
      biometricAuthenticateUsecase: sl(),
      forgotPassUsecase: sl(),
    ),
  );
  sl.registerSingleton<UserSetupBloc>(
    UserSetupBloc(
      pickAvatarFromGalleryUsecase: sl(),
      pickAvatarFromCameraUsecase: sl(),
      saveUserUsecase: sl(),
      checkUsernameAvailableUsecase: sl(),
      getCurrentLocationUsecase: sl(),
    ),
  );
  sl.registerSingleton<MapBloc>(MapBloc());
}
