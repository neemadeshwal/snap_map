import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/predictive_back_event.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/entities/user_entity.dart';
import 'package:snapmap/features/auth/domain/repository/auth_repository.dart';
import 'package:snapmap/features/auth/domain/usecases/biometric_authenticate.dart';
import 'package:snapmap/features/auth/domain/usecases/forgot_password.dart';
import 'package:snapmap/features/auth/domain/usecases/get_current_user.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_out.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_up_with_email.dart';

// Fake SignInWithEmail
class FakeSignInWithEmail implements SignInWithEmail {
  bool shouldFail = false;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(SigninParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Sign in failed'));
    }
    return Right(
      UserEntity(
        uid: 'user123',
        name: 'Test User',
        email: params.email,
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime(2024, 1, 1),
        lastLoginAt: null,
      ),
    );
  }
}

// Fake SignUpWithEmail
class FakeSignUpWithEmail implements SignUpWithEmail {
  bool shouldFail = false;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(SignupParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Sign up failed'));
    }
    return Right(
      UserEntity(
        uid: 'user123',
        name: params.name,
        email: params.email,
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime.now(),
        lastLoginAt: null,
      ),
    );
  }
}

// Fake SignOut
class FakeSignOut implements SignOut {
  bool shouldFail = false;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Sign out failed'));
    }
    return const Right(null);
  }
}

// Fake GetCurrentUser
class FakeGetCurrentUser implements GetCurrentUser {
  bool shouldFail = false;
  UserEntity? userToReturn;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Get current user failed'));
    }
    return Right(
      userToReturn ??
          UserEntity(
            uid: 'user123',
            name: 'Test User',
            email: 'test@example.com',
            phoneNumber: null,
            photoUrl: null,
            createdAt: DateTime(2024, 1, 1),
            lastLoginAt: null,
          ),
    );
  }
}

// Fake SignInWithGoogle
class FakeSignInWithGoogle implements SignInWithGoogle {
  bool shouldFail = false;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Google sign in failed'));
    }
    return Right(
      UserEntity(
        uid: 'google123',
        name: 'Google User',
        email: 'google@gmail.com',
        phoneNumber: null,
        photoUrl: null,
        createdAt: DateTime.now(),
        lastLoginAt: null,
      ),
    );
  }
}

// Fake BiometricAuthenticate
class FakeBiometricAuthenticate implements BiometricAuthenticate {
  bool shouldFail = false;
  bool authResult = true;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(BiometricAuthenticateParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Biometric auth failed'));
    }
    return Right(authResult);
  }
}

// Fake ForgotPassword
class FakeForgotPassword implements ForgotPassword {
  bool shouldFail = false;

  @override
  late AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    if (shouldFail) {
      return Left(AuthFailure('Forgot password failed'));
    }
    return const Right(null);
  }
}

// Fake AppLifecycleManager
// Fake AppLifecycleManager
class FakeAppLifecycleManager implements AppLifecycleManager {
  @override
  VoidCallback? onAppPaused;

  @override
  VoidCallback? onAppResumed;

  @override
  void resetPauseTime() {}

  @override
  bool shouldRequireReAuth({Duration threshold = const Duration(minutes: 5)}) {
    return false;
  }

  // Implement WidgetsBindingObserver methods (empty)
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  Future<bool> didPopRoute() async => false;

  @override
  Future<bool> didPushNewRouteInformation(
    RouteInformation routeInformation,
  ) async => false;

  @override
  Future<bool> didPushRoute(String route) async => false;

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<AppExitResponse> didRequestAppExit() async => AppExitResponse.exit;

  // ADD THESE MISSING ONES:
  @override
  void didChangeViewFocus(ViewFocusEvent event) {}

  @override
  Future<bool> didPushRouteInformation(
    RouteInformation routeInformation,
  ) async => false;

  @override
  void handleCancelBackGesture() {}

  @override
  void handleCommitBackGesture() {}

  @override
  void handlePopRoute() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  int getBackgroundDurationSeconds() {
    // TODO: implement getBackgroundDurationSeconds
    throw UnimplementedError();
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    // TODO: implement handleStartBackGesture
    throw UnimplementedError();
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    // TODO: implement handleUpdateBackGestureProgress
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void recordUserActivity() {
    // TODO: implement recordUserActivity
  }
}
