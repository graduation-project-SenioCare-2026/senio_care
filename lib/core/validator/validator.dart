import 'package:flutter/material.dart';
import 'package:senio_care/core/extension/app_localization_extension.dart';

class Validator {
  Validator._();

  // Email Validator
  static String? validateEmail(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return context.locale.emailRequired;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
      return context.locale.emailNotValid;
    } else {
      return null;
    }
  }

  // Password Validator
  static String? validatePassword(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.locale.passwordRequired;
    }

    if (val.length < 8) {
      return context.locale.passwordMinLength;
    }

    if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return context.locale.passwordUppercase;
    }

    if (!RegExp(r'[a-z]').hasMatch(val)) {
      return context.locale.passwordMustContainLowerCase;
    }

    if (!RegExp(r'[0-9]').hasMatch(val)) {
      return context.locale.passwordNumber;
    }

    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(val)) {
      return context.locale.passwordMustContainSpecialChar;
    }

    return null;
  }

  // Confirm Password Validator
  static String? validateConfirmPassword(
      BuildContext context, String? val, String? password) {
    if (val == null || val.isEmpty) {
      return context.locale.fieldRequired;
    } else if (val != password) {
      return context.locale.passwordsNotMatch;
    } else {
      return null;
    }
  }

  // Username Validator
  static String? validateUsername(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.locale.usernameRequired;
    } else if (!RegExp(r'^[a-zA-Z0-9,.-]+$').hasMatch(val)) {
      return context.locale.usernameNotValid;
    } else {
      return null;
    }
  }

  // Full Name Validator
  static String? validateFullName(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.locale.fullnameRequired;
    }
    if (val.trim().length < 3) {
      return context.locale.fullnameMinLength;
    } else {
      return null;
    }
  }

  // Phone Number Validator
  static String? validatePhoneNumber(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.locale.phoneRequired;
    } else if (!RegExp(r'^[0-9+\-() ]+$').hasMatch(val.trim())) {
      return context.locale.phoneNumbersOnly;
    } else if (val.trim().replaceAll(RegExp(r'[^\d]'), '').length < 10) {
      return context.locale.phoneLength;
    } else {
      return null;
    }
  }

  // Number Validator
  static String? validateNumber(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.locale.numberRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return context.locale.numberOnly;
    } else {
      return null;
    }
  }

  // Service Description Validator (for "Add New Service" screen)
  static String? validateServiceDescription(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Service description is required';
    }
    if (val.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    if (val.trim().length > 500) {
      return 'Description must not exceed 500 characters';
    }
    return null;
  }

  // Location Validator (for registration form)
  static String? validateLocation(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Location is required';
    }
    if (val.trim().length < 3) {
      return 'Location must be at least 3 characters';
    }
    return null;
  }

  // Specialization Validator
  static String? validateSpecialization(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Specialization is required';
    }
    if (val.trim().length < 3) {
      return 'Specialization must be at least 3 characters';
    }
    return null;
  }

  // Age Validator (for Medical History form)
  static String? validateAge(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(val.trim());
    if (age == null) {
      return 'Age must be a number';
    }
    if (age < 0 || age > 150) {
      return 'Please enter a valid age';
    }
    return null;
  }

  // Weight Validator
  static String? validateWeight(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Weight is required';
    }
    final weight = double.tryParse(val.trim());
    if (weight == null) {
      return 'Weight must be a number';
    }
    if (weight < 1 || weight > 500) {
      return 'Please enter a valid weight (1-500 kg)';
    }
    return null;
  }

  // Height Validator
  static String? validateHeight(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Height is required';
    }
    final height = double.tryParse(val.trim());
    if (height == null) {
      return 'Height must be a number';
    }
    if (height < 50 || height > 300) {
      return 'Please enter a valid height (50-300 cm)';
    }
    return null;
  }

  // Medicine Name Validator (for "Add Reminder" screen)
  static String? validateMedicineName(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Medicine name is required';
    }
    if (val.trim().length < 2) {
      return 'Medicine name must be at least 2 characters';
    }
    return null;
  }

  // Document Name Validator (for "Add Document" screen)
  static String? validateDocumentName(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Document name is required';
    }
    if (val.trim().length < 3) {
      return 'Document name must be at least 3 characters';
    }
    return null;
  }

  // Elder Token Validator
  static String? validateElderToken(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Elder token is required';
    }
    if (val.trim().length < 6) {
      return 'Elder token must be at least 6 characters';
    }
    // You can add specific pattern validation if tokens have a specific format
    return null;
  }

  // Generic Required Field Validator
  static String? validateRequired(BuildContext context, String? val, {String? fieldName}) {
    if (val == null || val.trim().isEmpty) {
      return '${fieldName ?? "This field"} is required';
    }
    return null;
  }

  // Dropdown/Selection Validator
  static String? validateSelection(BuildContext context, dynamic val, {String? fieldName}) {
    if (val == null) {
      return 'Please select ${fieldName ?? "an option"}';
    }
    return null;
  }

  // Time Validator (for medicine reminders)
  static String? validateTime(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Time is required';
    }
    // You can add more specific time format validation if needed
    return null;
  }

  // Date Validator
  static String? validateDate(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Date is required';
    }
    return null;
  }

  // Chronic Disease Validator (optional field but with validation if filled)
  static String? validateChronicDisease(BuildContext context, String? val) {
    if (val != null && val.trim().isNotEmpty && val.trim().length < 3) {
      return 'Please provide more details (at least 3 characters)';
    }
    return null;
  }

  // Allergy Validator (optional field but with validation if filled)
  static String? validateAllergy(BuildContext context, String? val) {
    if (val != null && val.trim().isNotEmpty && val.trim().length < 3) {
      return 'Please provide more details (at least 3 characters)';
    }
    return null;
  }

  // Gender Validator (for radio button selections)
  static String? validateGender(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a gender';
    }
    return null;
  }
}