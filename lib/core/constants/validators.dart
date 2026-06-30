import 'package:intl/intl.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    final bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
    final bool hasNumber = value.contains(RegExp(r'[0-9]'));
    final bool hasSpecialCharacter = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUpperCase || !hasLowerCase || !hasNumber || !hasSpecialCharacter) {
      return 'Password must include uppercase, lowercase, number, and special character';
    }
    return null;
  }

  static String? validateText(String? value, {int minLength = 2, int maxLength = 100}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return 'Minimum $minLength characters required';
    }
    if (value.length > maxLength) {
      return 'Maximum $maxLength characters allowed';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      return 'Invalid date format (yyyy-MM-dd)';
    }
    return null;
  }

  static String? validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }
}
