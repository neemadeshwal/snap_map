class AppConstants {
  static const String welcome = 'welcome';
  static const String welcomeBack = "welcome back";
  static const String loginContent = "enter your credentials";
  static const String signupContent =
      'create account to explore amazing things';
  static const String fullname = "full name";
  static const String enterFullname = "enter your full name";
  static const String emailAddress = "email address";
  static const String enterEmailaddress = "enter your email address";
  static const String password = "Password";
  static const String enterPassword = "enter your password";
  static const String confirmPassword = "Confirm Password";
  static const String signupwithgoogle = "sign up with google";
  static const String signinwithgoogle = "sign in with google";

  static const String signupwithfacebook = "sign up with facebook";
  static const String signinwithfacebook = "sign in with facebook";

  static const String orsignupwithemail = "or signup with email";
  static const String orsigninwithemail = "or signin with email";

  static const String create = "create";
  static const String alreadyHaveAnAccount = "already have an account?";
  static const String dontHaveAnAccount = "don't have an account?";
  static const String logIn = "log in";

  static const String continueBtn = "continue";
  static const String forgotPassword = "forgot password";
  static const String forgotPasswordContent =
      "enter your email to reset your password.";
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static const num minNameLength = 3;
  static const num maxNameLength = 20;
  static const num minPasswordLength = 7;
  static const num maxPasswordLength = 25;
}
