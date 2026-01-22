import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownPopupBuilder<T> {
  static PopupPropsMultiSelection<T> buildPopupProps<T>({
    required BuildContext context,
    required Widget Function(BuildContext, List<T>) validationBuilder,
    required Widget Function(BuildContext, T, bool, bool) checkBoxBuilder,
    required Widget Function(BuildContext, T, bool, bool) itemBuilder,
    required DialogProps dialogProps,
    required TextFieldProps searchFieldProps,
    required Widget Function(BuildContext, String) emptyBuilder,
  }) {
    return PopupPropsMultiSelection.dialog(
      showSearchBox: true,
      showSelectedItems: true,
      validationBuilder: (context, selectedItems) =>
          validationBuilder(context, selectedItems),
      checkBoxBuilder: (context, item, isDisabled, isSelected) =>
          checkBoxBuilder(context, item, isDisabled, isSelected),
      itemBuilder: (context, item, isDisabled, isSelected) =>
          itemBuilder(context, item, isDisabled, isSelected),
      dialogProps: dialogProps,
      searchFieldProps: searchFieldProps,
      emptyBuilder: (context, searchText) =>
          emptyBuilder(context, searchText),
    );
  }
}