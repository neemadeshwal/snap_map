import 'package:bloc/bloc.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/usecases/usecase.dart';
import 'package:snapmap/features/auth/domain/usecases/biometric_authenticate.dart';
import 'package:snapmap/features/auth/domain/usecases/forgot_password.dart';
import 'package:snapmap/features/auth/domain/usecases/get_current_user.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_out.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInUsecase;
  final SignUpWithEmail signUpUsecase;
  final SignOut signOutUsecase;
  final GetCurrentUser getCurrentUserUsecase;
  final SignInWithGoogle signInWithGoogleUsecase;
  final AppLifecycleManager appLifecycleManager;
  final BiometricAuthenticate biometricAuthenticateUsecase;
  final ForgotPassword forgotPassUsecase;
  bool _isReauthInProgress = false;

  AuthBloc({
    required this.signInUsecase,
    required this.signOutUsecase,
    required this.signUpUsecase,
    required this.getCurrentUserUsecase,
    required this.signInWithGoogleUsecase,
    required this.appLifecycleManager,
    required this.biometricAuthenticateUsecase,
    required this.forgotPassUsecase,
  }) : super(AuthInitial()) {
    on<SigninRequested>(_onSigninRequested);
    on<SignoutRequested>(_onSignoutRequested);
    on<SignupRequested>(_onSignupRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<SigninWithGoogleRequested>(_onSigninWithGoogleRequested);
    on<SessionExpiredRequested>(_onSessionExpired);
    on<ReauthenticateWithBiometricRequested>(_onReAuthenticateBiometric);
    on<ForgotPassRequested>(_onForgotPasswordRequested);
    appLifecycleManager.onAppPaused = _handleAppPaused;
    appLifecycleManager.onAppResumed = _handleAppResumed;
  }

  Future<void> _onSigninRequested(
    SigninRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signInUsecase(
      SigninParams(email: event.email, password: event.password),
    );
    await result.fold(
      (failure) async {
        emit(AuthError("signin failed"));
      },
      (user) async {
        emit(Authenticated());
      },
    );
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signUpUsecase(
      SignupParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    await result.fold(
      (failure) async {
        print(failure);
        emit(AuthError("signup failed"));
      },
      (user) async {
        emit(Authenticated());
      },
    );
  }

  Future<void> _onSignoutRequested(
    SignoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signOutUsecase(NoParams());
    await result.fold(
      (failure) async {
        emit(AuthError("sign out failed"));
      },
      (_) async {
        emit(Unauthenticated());
      },
    );
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('🔍 CheckAuthStatus started');
    final result = await getCurrentUserUsecase(const NoParams());

    await result.fold(
      (failure) async {
        emit(Unauthenticated());
      },
      (user) async {
        print('✅ getCurrentUser returned: $user');
        if (user != null) {
          emit(SessionExpired());
          // final shouldReauth = appLifecycleManager.shouldRequireReAuth(
          //   threshold: const Duration(seconds: 30),
          // );
          // if (shouldReauth) {
          //   emit(SessionExpired());
          // } else {
          //   emit(Authenticated());
          // }
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onSigninWithGoogleRequested(
    SigninWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signInWithGoogleUsecase(const NoParams());
    await result.fold(
      (failure) async {
        emit(AuthError("google signin failed"));
      },
      (user) async {
        emit(Authenticated());
      },
    );
  }

  // ===== RE-AUTHENTICATE WITH BIOMETRIC (Session timeout) =====

  Future<void> _onReAuthenticateBiometric(
    ReauthenticateWithBiometricRequested event,
    Emitter<AuthState> emit,
  ) async {
    _isReauthInProgress = true;
    emit(AuthLoading());
    final availableResult = await biometricAuthenticateUsecase.repository
        .isBiometricAvailable();

    final available = availableResult.fold(
      (_) => false,
      (available) => available,
    );
    if (!available) {
      _isReauthInProgress = false;
      appLifecycleManager.resetPauseTime();
      emit(Authenticated());
      return;
    }
    final result = await biometricAuthenticateUsecase(
      BiometricAuthenticateParams(
        reason: "Verify identity to continue",
        useDevicePasscode: true,
      ),
    );

    await result.fold(
      (failure) async {
        _isReauthInProgress = false;
        emit(SessionExpired());
      },

      (isAuthenticated) async {
        if (isAuthenticated) {
          _isReauthInProgress = false;
          appLifecycleManager.resetPauseTime();
          emit(AuthSessionRefreshed());
        } else {
          _isReauthInProgress = false;
          emit(SessionExpired());
        }
      },
    );
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPassRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await forgotPassUsecase(
      ForgotPasswordParams(email: event.email),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(ForgotPassLinkSuccess()),
    );
  }

  Future<void> _onSessionExpired(
    SessionExpiredRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(SessionExpired());
  }

  void _handleAppPaused() {
    print('⏸ App paused');
  }

  void _handleAppResumed() {
    print('🔄 App resumed');
    if (_isReauthInProgress) return;
    final shouldReauth = appLifecycleManager.shouldRequireReAuth(
      threshold: const Duration(seconds: 30),
    );
    if (shouldReauth) {
      _isReauthInProgress = true;
      print('⏰ Re-auth needed');
      add(SessionExpiredRequested());
    } else {
      print('✓ Session valid');
      appLifecycleManager.resetPauseTime();
    }
  }
}
