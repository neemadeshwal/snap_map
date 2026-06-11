import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'SnapMap'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginContent.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials'**
  String get loginContent;

  /// No description provided for @signupContent.
  ///
  /// In en, this message translates to:
  /// **'Create account to explore amazing things'**
  String get signupContent;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// No description provided for @enterFullname.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullname;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @signupWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signupWithGoogle;

  /// No description provided for @signinWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signinWithGoogle;

  /// No description provided for @signupWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Facebook'**
  String get signupWithFacebook;

  /// No description provided for @signinWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get signinWithFacebook;

  /// No description provided for @orSignupWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Or signup with email'**
  String get orSignupWithEmail;

  /// No description provided for @orSigninWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Or signin with email'**
  String get orSigninWithEmail;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordContent.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password.'**
  String get forgotPasswordContent;

  /// No description provided for @createYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Your Profile'**
  String get createYourProfile;

  /// No description provided for @userSetupContent.
  ///
  /// In en, this message translates to:
  /// **'This is how others will discover you on the map'**
  String get userSetupContent;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @yourHandle.
  ///
  /// In en, this message translates to:
  /// **'yourhandle'**
  String get yourHandle;

  /// No description provided for @howYourNameAppears.
  ///
  /// In en, this message translates to:
  /// **'How your name appears'**
  String get howYourNameAppears;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell people what you\'re about..'**
  String get bioHint;

  /// No description provided for @yourInterests.
  ///
  /// In en, this message translates to:
  /// **'Your interests (pick a few)'**
  String get yourInterests;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocation;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @currentCity.
  ///
  /// In en, this message translates to:
  /// **'Indiranagar, Bengaluru'**
  String get currentCity;

  /// No description provided for @sessionRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Session refreshed'**
  String get sessionRefreshed;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @goingCountText.
  ///
  /// In en, this message translates to:
  /// **'going'**
  String get goingCountText;

  /// No description provided for @interestedCountText.
  ///
  /// In en, this message translates to:
  /// **'interested'**
  String get interestedCountText;

  /// No description provided for @awayText.
  ///
  /// In en, this message translates to:
  /// **'away'**
  String get awayText;

  /// No description provided for @goingBtn.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get goingBtn;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Check your email for the password reset link'**
  String get passwordResetEmailSent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
