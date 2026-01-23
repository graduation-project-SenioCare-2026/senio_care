import 'package:easy_localization/easy_localization.dart';

class Validator {
  Validator._();

  // Email Validator
  static String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'emailRequired'.tr();
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
      return 'emailNotValid'.tr();
    }
    return null;
  }

  // Password Validator
  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'passwordRequired'.tr();
    if (val.length < 8) return 'passwordMinLength'.tr();
    if (!RegExp(r'[A-Z]').hasMatch(val)) return 'passwordUppercase'.tr();
    if (!RegExp(r'[a-z]').hasMatch(val)) return 'passwordMustContainLowerCase'.tr();
    if (!RegExp(r'[0-9]').hasMatch(val)) return 'passwordNumber'.tr();
    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(val)) return 'passwordMustContainSpecialChar'.tr();
    return null;
  }

  // Confirm Password Validator
  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) return 'fieldRequired'.tr();
    if (val != password) return 'passwordsNotMatch'.tr();
    return null;
  }

  // Username Validator
  static String? validateUsername(String? val) {
    if (val == null || val.isEmpty) return 'usernameRequired'.tr();
    if (!RegExp(r'^[a-zA-Z0-9,.-]+$').hasMatch(val)) return 'usernameNotValid'.tr();
    return null;
  }

  // Full Name Validator
  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) return 'fullnameRequired'.tr();
    if (val.trim().length < 3) return 'fullnameMinLength'.tr();
    return null;
  }

  // Egyptian Phone Number Validator (Local only)
  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'phoneRequired'.tr();
    }

    final phone = val.trim();

    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      return 'phoneNumbersOnly'.tr();
    }

    if (phone.length != 11) {
      return 'phoneLength'.tr();
    }

    if (!RegExp(r'^01[0125]').hasMatch(phone)) {
      return 'invalidEgyptianPhone'.tr();
    }

    return null;
  }


  // Number Validator
  static String? validateNumber(String? val) {
    if (val == null || val.isEmpty) return 'numberRequired'.tr();
    if (int.tryParse(val.trim()) == null) return 'numberOnly'.tr();
    return null;
  }

  // Service Description Validator
  static String? validateServiceDescription(String? val) {
    if (val == null || val.trim().isEmpty) return 'serviceDescriptionRequired'.tr();
    if (val.trim().length < 10) return 'serviceDescriptionMinLength'.tr();
    if (val.trim().length > 500) return 'serviceDescriptionMaxLength'.tr();
    return null;
  }

  // Location Validator
  static String? validateLocation(String? val) {
    if (val == null || val.trim().isEmpty) return 'locationRequired'.tr();
    if (val.trim().length < 3) return 'locationMinLength'.tr();
    return null;
  }

  // Specialization Validator
  static String? validateSpecialization(String? val) {
    if (val == null || val.trim().isEmpty) return 'specializationRequired'.tr();
    if (val.trim().length < 3) return 'specializationMinLength'.tr();
    return null;
  }

  // Age Validator
  static String? validateAge(String? val) {
    if (val == null || val.isEmpty) return 'ageRequired'.tr();
    final age = int.tryParse(val.trim());
    if (age == null) return 'ageMustBeNumber'.tr();
    if (age < 0 || age > 150) return 'ageNotValid'.tr();
    return null;
  }

  // Weight Validator
  static String? validateWeight(String? val) {
    if (val == null || val.isEmpty) return 'weightRequired'.tr();
    final weight = double.tryParse(val.trim());
    if (weight == null) return 'weightMustBeNumber'.tr();
    if (weight < 1 || weight > 500) return 'weightNotValid'.tr();
    return null;
  }

  // Height Validator
  static String? validateHeight(String? val) {
    if (val == null || val.isEmpty) return 'heightRequired'.tr();
    final height = double.tryParse(val.trim());
    if (height == null) return 'heightMustBeNumber'.tr();
    if (height < 50 || height > 300) return 'heightNotValid'.tr();
    return null;
  }

  // Medicine Name Validator
  static String? validateMedicineName(String? val) {
    if (val == null || val.trim().isEmpty) return 'medicineNameRequired'.tr();
    if (val.trim().length < 2) return 'medicineNameMinLength'.tr();
    return null;
  }

  // Document Name Validator
  static String? validateDocumentName(String? val) {
    if (val == null || val.trim().isEmpty) return 'documentNameRequired'.tr();
    if (val.trim().length < 3) return 'documentNameMinLength'.tr();
    return null;
  }

  // Elder Token Validator
  // static String? validateElderToken(String? val) {
  //   if (val == null || val.trim().isEmpty) return 'elderTokenRequired'.tr();
  //   if (val.trim().length < 6) return 'elderTokenMinLength'.tr();
  //   return null;
  // }

  // Id Validator
  static String? validateId(String? val) {
    if (val == null || val.trim().isEmpty) return 'fieldRequired'.tr();
    if (!RegExp(r'^[a-f0-9]{24}$').hasMatch(val.trim())) return 'invalidId'.tr();
    return null;
  }

  // Generic Required Field Validator
  static String? validateRequired(String? val, {String? fieldName}) {
    if (val == null || val.trim().isEmpty) return (fieldName ?? 'fieldRequired').tr();
    return null;
  }

  // Dropdown/Selection Validator
  static String? validateSelection(dynamic val, {String? fieldName}) {
    if (val == null) return 'pleaseSelect ${fieldName ?? 'anOption'}'.tr();
    return null;
  }

  // Time Validator
  static String? validateTime(String? val) {
    if (val == null || val.trim().isEmpty) return 'timeRequired'.tr();
    return null;
  }

  // Date Validator
  static String? validateDate(String? val) {
    if (val == null || val.trim().isEmpty) return 'dateRequired'.tr();
    return null;
  }

  // Chronic Disease Validator
  static String? validateChronicDisease(String? val) {
    if (val != null && val.trim().isNotEmpty && val.trim().length < 3) return 'chronicDiseaseTooShort'.tr();
    return null;
  }

  // Allergy Validator
  static String? validateAllergy(String? val) {
    if (val != null && val.trim().isNotEmpty && val.trim().length < 3) return 'allergyTooShort'.tr();
    return null;
  }

  // Gender Validator
  static String? validateGender(String? val) {
    if (val == null || val.isEmpty) return 'pleaseSelectGender'.tr();
    return null;
  }
}
