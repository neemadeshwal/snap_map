import 'dart:ui';

abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;
  ChangeLanguage(this.languageCode);
}

class AutoDetectLanguage extends LanguageEvent {}
