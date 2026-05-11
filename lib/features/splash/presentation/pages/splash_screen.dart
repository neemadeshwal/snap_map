import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckAuthStatusRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go(RouteConstants.signin);
        } else if (state is SessionExpired) {
          context.read<AuthBloc>().add(ReauthenticateWithBiometricRequested());
        } else if (state is Authenticated) {
          context.go(RouteConstants.home);
        } else if (state is AuthSessionRefreshed) {
          context.go(RouteConstants.home);
        }
      },
      child: Scaffold(
        body: SafeArea(child: Center(child: Text("SnapMap"))),
      ),
    );
  }
}
