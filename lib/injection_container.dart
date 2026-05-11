import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  // ==== app life cycle manager ===========
  // firebase instance

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => LocalAuthentication());

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

  // auth repo

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: sl()),
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
}
