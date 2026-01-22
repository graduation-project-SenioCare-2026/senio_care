import 'package:easy_localization/easy_localization.dart';

class DropdownValidators {
  /// Validate that the list is not empty
  static String? validateRequired<T>(List<T>? value) {
    if (value == null || value.isEmpty) {
      return 'requiredField'.tr();
    }
    return null;
  }

  /// Check if item already exists (case-insensitive)
  static bool itemExists<T>(
      String inputText,
      List<T> items,
      String Function(T) itemAsString,
      ) {
    final inputTextLower = inputText.trim().toLowerCase();
    return items.any((item) {
      final existingText = itemAsString(item);
      return existingText.toLowerCase() == inputTextLower;
    });
  }

  /// Get validator for duplicate checking
  static String? Function(String?)? getDuplicateValidator<T>(
      List<T> selectedItems,
      String Function(T) itemAsString,
      ) {
    return (value) {
      if (value != null && value.trim().isNotEmpty) {
        final inputText = value.trim();
        final inputTextLower = inputText.toLowerCase();
        final exists = selectedItems.any((item) {
          final existingText = itemAsString(item);
          return existingText.toLowerCase() == inputTextLower;
        });
        if (exists) {
          return 'itemAlreadyExists'.tr();
        }
      }
      return null;
    };
  }
}