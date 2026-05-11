import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapmap/core/config/route_config.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/theme/app_theme.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/firebase_options.dart';
import 'package:snapmap/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLifecycle = AppLifecycleManager();
  appLifecycle.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized!');
  } catch (error) {
    print('❌ Firebase error: $error');
  }

  await GoogleSignIn.instance.initialize();
  await di.init();
  print('✅ Dependencies initialized!');

  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => di.sl<AuthBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = RouteConfig.router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'SnapMap',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        routerConfig: _router,
      ),
    );
  }
}
