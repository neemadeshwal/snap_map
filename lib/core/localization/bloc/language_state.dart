import 'dart:ui';

import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);
  @override
  List<Object> get props => [locale];

  String get currentLanguageName {
    switch (locale.languageCode) {
      case 'hi':
        return 'हिन्दी';
      case 'kn':
        return 'ಕನ್ನಡ';
      default:
        return 'English';
    }
  }
}
