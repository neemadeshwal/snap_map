import 'package:snapmap/core/constants/app_constants.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!AppConstants.emailRegex.hasMatch(value.trim())) {
      return 'Please provide valid email';
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required';
    }
    if (value.length < AppConstants.minNameLength) {
      return 'username must be atleast ${AppConstants.minNameLength}';
    }
    if (value.length > AppConstants.maxNameLength) {
      return 'username must be atmost ${AppConstants.maxNameLength}';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must be less than ${AppConstants.maxPasswordLength} characters';
    }
    return null;
  }

  // Confirm password validation
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
