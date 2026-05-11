import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:snapmap/features/auth/presentation/screens/signin_screen.dart';
import 'package:snapmap/features/auth/presentation/screens/signup_screen.dart';
import 'package:snapmap/features/home/presentation/screens/home_screen.dart';
import 'package:snapmap/features/onboarding/presentation/pages/user_setup/user_setup_screen.dart';
import 'package:snapmap/features/splash/presentation/pages/splash_screen.dart';

class RouteConfig {
  RouteConfig._();

  static final GoRouter _router = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RouteConstants.signin,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: RouteConstants.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteConstants.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteConstants.userSetup,
        builder: (context, state) => const UserSetupScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
