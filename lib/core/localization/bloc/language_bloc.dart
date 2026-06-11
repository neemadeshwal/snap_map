import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapmap/core/localization/bloc/language_event.dart';
import 'package:snapmap/core/localization/bloc/language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(_getDeviceLocale())) {
    on<AutoDetectLanguage>((event, emit) {
      emit(LanguageState(_getDeviceLocale()));
    });
  }
  static Locale _getDeviceLocale() {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;

    final deviceLocale = dispatcher.locale;
    print('📱 Device locales: ${dispatcher.locales}');
    print('📱 Primary locale: ${dispatcher.locale}');
    final supportedLanguages = ['en', 'hi', 'kn'];

    if (supportedLanguages.contains(deviceLocale.languageCode)) {
      return Locale(deviceLocale.languageCode);
    }
    for (final locale in dispatcher.locales) {
      if (supportedLanguages.contains(locale.languageCode)) {
        return Locale(locale.languageCode);
      }
    }
    return const Locale('en');
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageState(Locale(json['languageCode'] as String));
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {'languageCode': state.locale.languageCode};
  }
}
