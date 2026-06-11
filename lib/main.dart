import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapmap/core/config/route_config.dart';
import 'package:snapmap/core/localization/bloc/language_bloc.dart';
import 'package:snapmap/core/localization/bloc/language_state.dart';
import 'package:snapmap/core/services/app_lifecycle_manager.dart';
import 'package:snapmap/core/theme/app_theme.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/firebase_options.dart';
import 'package:snapmap/generated/app_localizations.dart';
import 'package:snapmap/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await HydratedBloc.storage.clear();

  // await FlutterLocalization.instance.ensureInitialized();
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
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
        BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
      ],
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
      builder: (context, child) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'SnapMap',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,

              routerConfig: _router,
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('hi'),
                Locale('kn'),
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                if (locale != null) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode) {
                      return supportedLocale;
                    }
                  }
                }
                return const Locale('en');
              },
            );
          },
        );
      },
    );
  }
}
