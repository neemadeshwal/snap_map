import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';
import 'package:snapmap/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late AppLifecycleManager _appLifecycleManager;

  @override
  void initState() {
    super.initState();
    _appLifecycleManager = sl<AppLifecycleManager>();
  }

  void _handleSignout() {
    context.read<AuthBloc>().add(SignoutRequested());
  }

  void _recordUserActivity() {
    _appLifecycleManager.recordUserActivity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SessionExpired) {
          context.read<AuthBloc>().add(ReauthenticateWithBiometricRequested());
        } else if (state is AuthSessionRefreshed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('✓ Session refreshed')));
        } else if (state is Unauthenticated) {
          context.go(RouteConstants.signin);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: _recordUserActivity,
            child: Center(
              child: CustomButton.primary(
                text: "Log out",
                onPressed: _handleSignout,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
