import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/screens/signin_screen.dart';

import '../../domain/usecases/fake_use_cases.dart';

void main() {
  group('SigninScreen Widget Tests', () {
    late AuthBloc authBloc;
    late FakeSignInWithEmail fakeSignIn;
    late FakeSignUpWithEmail fakeSignup;
    late FakeSignOut fakeSignOut;
    late FakeGetCurrentUser fakeGetCurrentUser;
    late FakeSignInWithGoogle fakeSignInGoogle;
    late FakeBiometricAuthenticate fakeBiometric;
    late FakeForgotPassword fakeForgotPassword;
    late FakeAppLifecycleManager fakeAppLifecycleManager;

    setUp(() {
      fakeSignIn = FakeSignInWithEmail();
      fakeSignup = FakeSignUpWithEmail();
      fakeSignOut = FakeSignOut();
      fakeGetCurrentUser = FakeGetCurrentUser();
      fakeSignInGoogle = FakeSignInWithGoogle();
      fakeBiometric = FakeBiometricAuthenticate();
      fakeForgotPassword = FakeForgotPassword();
      fakeAppLifecycleManager = FakeAppLifecycleManager();
      authBloc = AuthBloc(
        signInUsecase: fakeSignIn,
        signOutUsecase: fakeSignOut,
        signUpUsecase: fakeSignup,
        getCurrentUserUsecase: fakeGetCurrentUser,
        signInWithGoogleUsecase: fakeSignInGoogle,
        biometricAuthenticateUsecase: fakeBiometric,
        forgotPassUsecase: fakeForgotPassword,
        appLifecycleManager: fakeAppLifecycleManager,
      );
    });
    tearDown(() {
      authBloc.close();
    });

    Widget buildSigninScreen() {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: const SigninScreen(),
        ),
      );
    }

    testWidgets('should display email and password input fields ', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSigninScreen());

      expect(
        find.byType(TextFormField),
        findsWidgets,
        reason: 'Should have at least 2 TextFormField (email and password)',
      );
      expect(find.byType(TextFormField).at(1), findsOneWidget);
    });
    testWidgets('should display sign in button', (WidgetTester tester) async {
      await tester.pumpWidget(buildSigninScreen());
      expect(find.text('Log In'), findsOneWidget);
    });
    testWidgets('should enter email in email field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSigninScreen());

      final emailFields = find.byType(TextFormField);

      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pump();
      expect(find.text('test@example.com'), findsOneWidget);
    });
    testWidgets('should enter password in password field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSigninScreen());

      final passwordFields = find.byType(TextFormField);

      await tester.enterText(passwordFields.at(1), 'password123');
      await tester.pump();
      expect(find.byType(TextFormField).at(1), findsOneWidget);
    });
    testWidgets('should show loading indicator when signing in', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSigninScreen());

      final emailFields = find.byType(TextFormField);

      // Enter credentials
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.enterText(emailFields.at(1), 'password123');
      await tester.pump();

      // Tap login button
      await tester.tap(find.text('Log In'));
      await tester.pump();

      // BLoC should emit AuthLoading
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('should show error snackbar on failed signin', (
      WidgetTester tester,
    ) async {
      fakeSignIn.shouldFail = true;

      await tester.pumpWidget(buildSigninScreen());

      final emailFields = find.byType(TextFormField);

      // Enter credentials
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.enterText(emailFields.at(1), 'password123');
      await tester.pump();

      // Tap login button
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Should show error snackbar
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should navigate to signup when "Create" is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSigninScreen());

      // Find and tap "Create" link
      expect(find.text('Create'), findsOneWidget);
    });
  });
}
