import 'package:flutter_test/flutter_test.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';

import '../../domain/usecases/fake_use_cases.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('AuthBloc - SignIn', () {
    late AuthBloc authBloc;
    late FakeSignInWithEmail fakeSignIn;
    late FakeSignUpWithEmail fakeSignup;
    late FakeSignOut fakeSignOut;
    late FakeGetCurrentUser fakeGetCurrentUser;
    late FakeSignInWithGoogle fakeSignInWithGoogle;
    late FakeBiometricAuthenticate fakeBiometricAuthenticate;
    late FakeForgotPassword fakeForgotPassword;
    late FakeAppLifecycleManager fakeAppLifecycleManager;

    setUp(() {
      fakeSignIn = FakeSignInWithEmail();
      fakeSignup = FakeSignUpWithEmail();
      fakeSignOut = FakeSignOut();
      fakeGetCurrentUser = FakeGetCurrentUser();
      fakeSignInWithGoogle = FakeSignInWithGoogle();
      fakeBiometricAuthenticate = FakeBiometricAuthenticate();
      fakeForgotPassword = FakeForgotPassword();
      fakeAppLifecycleManager = FakeAppLifecycleManager();

      authBloc = AuthBloc(
        signInUsecase: fakeSignIn,
        signOutUsecase: fakeSignOut,
        signUpUsecase: fakeSignup,
        getCurrentUserUsecase: fakeGetCurrentUser,
        signInWithGoogleUsecase: fakeSignInWithGoogle,
        biometricAuthenticateUsecase: fakeBiometricAuthenticate,
        forgotPassUsecase: fakeForgotPassword,
        appLifecycleManager: fakeAppLifecycleManager,
      );
    });

    tearDown(() {
      authBloc.close();
    });

    blocTest<AuthBloc, AuthState>(
      'emit [loading,authenticated] when signin succeeds',
      build: () => authBloc,
      act: (bloc) => bloc.add(
        SigninRequested(email: 'test@example.com', password: 'password123'),
      ),
      expect: () => [isA<AuthLoading>(), isA<Authenticated>()],
    );
    blocTest<AuthBloc, AuthState>(
      'emit [loading, error] when signin fails',
      build: () => authBloc,
      setUp: () {
        fakeSignIn.shouldFail = true;
      },
      act: (bloc) => bloc.add(
        SigninRequested(email: 'test@example.com', password: 'wrongpassword'),
      ),
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );
  });
}
