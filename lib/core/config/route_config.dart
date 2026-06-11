import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/routes/route_screen.dart';
import 'package:snapmap/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:snapmap/features/auth/presentation/screens/signin_screen.dart';
import 'package:snapmap/features/auth/presentation/screens/signup_screen.dart';
import 'package:snapmap/features/chat/presentation/pages/chat_screen.dart';
import 'package:snapmap/features/explore/presentation/pages/explore_screen.dart';
import 'package:snapmap/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:snapmap/features/home/presentation/screens/home_screen.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:snapmap/features/onboarding/presentation/pages/user_setup/user_setup_screen.dart';
import 'package:snapmap/features/profile/presentation/profile_screen.dart';
import 'package:snapmap/features/splash/presentation/pages/splash_screen.dart';
import 'package:snapmap/injection_container.dart' as di;

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
        path: RouteConstants.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteConstants.userSetup,
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<UserSetupBloc>(),
          child: const UserSetupScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            RouteScreen(currentPath: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: RouteConstants.home,

            builder: (context, state) => BlocProvider(
              create: (_) => di.sl<MapBloc>(),
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.explore,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ExploreScreen()),
          ),
          GoRoute(
            path: RouteConstants.chat,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ChatScreen()),
          ),
          GoRoute(
            path: RouteConstants.profile,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
