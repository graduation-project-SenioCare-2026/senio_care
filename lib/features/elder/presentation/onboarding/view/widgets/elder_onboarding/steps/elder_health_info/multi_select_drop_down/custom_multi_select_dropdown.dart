import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/dropdown_other_option_field.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/dropdown_validators.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding/steps/elder_health_info/multi_select_drop_down/items_chips.dart';

class CustomMultiSelectDropdown<T> extends StatefulWidget {
  final BuildContext parentContext;
  final List<T> items;
  final List<T> selectedItems;
  final Function(List<T>) onItemsSelected;
  final String Function(T) itemAsString;
  final String Function(T)? itemAsStringSecondary;
  final bool Function(T, T) compareFn;
  final String hintText;
  final String searchHintText;
  final String emptyResultText;
  final String doneButtonText;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Widget Function(BuildContext, T)? chipBuilder;
  final bool showChips;
  final Function(T)? onChipDeleted;
  final bool enableOtherOption;
  final String otherOptionLabel;
  final String otherOptionHint;
  final T Function(String)? createCustomItem;
  final bool Function(T)? isOtherItem;

  const CustomMultiSelectDropdown({
    super.key,
    required this.parentContext,
    required this.items,
    required this.selectedItems,
    required this.onItemsSelected,
    required this.itemAsString,
    this.itemAsStringSecondary,
    required this.compareFn,
    this.hintText = 'Select items',
    this.searchHintText = 'Search...',
    this.emptyResultText = 'No results found',
    this.doneButtonText = 'done',
    this.prefixIcon,
    this.prefixIconColor,
    this.chipBuilder,
    this.showChips = true,
    this.onChipDeleted,
    this.enableOtherOption = true,
    this.otherOptionLabel = 'Other',
    this.otherOptionHint = 'Enter custom value...',
    this.createCustomItem,
    this.isOtherItem,
  });

  @override
  State<CustomMultiSelectDropdown<T>> createState() =>
      _CustomMultiSelectDropdownState<T>();
}

class _CustomMultiSelectDropdownState<T>
    extends State<CustomMultiSelectDropdown<T>> {
  final TextEditingController _otherController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormFieldState<List<T>> _formFieldState;

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: List<T>.from(widget.selectedItems),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => DropdownValidators.validateRequired(value),
      builder: (formState) {
        _formFieldState = formState;
        final hasError = formState.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownSearch<T>.multiSelection(
              items: _buildFilteredItems,
              selectedItems: formState.value ?? [],
              compareFn: widget.compareFn,
              onChanged: _handleItemsChanged,
              popupProps: _buildPopupProps(context, formState),
              dropdownBuilder: _buildDropdownBuilder,
              decoratorProps: _buildDecoratorProps(context, hasError),
            ),
            if (hasError) _buildErrorText(context, formState),
            if (widget.showChips && widget.selectedItems.isNotEmpty)
              _buildChipsSection(),
          ],
        );
      },
    );
  }

  Future<List<T>> _buildFilteredItems(String filter, _) async {
    if (filter.isEmpty) {
      return widget.items;
    }
    return widget.items.where((item) {
      final searchLower = filter.toLowerCase();
      final primaryMatch = widget
          .itemAsString(item)
          .toLowerCase()
          .contains(searchLower);

      if (widget.itemAsStringSecondary != null) {
        final secondaryMatch = widget.itemAsStringSecondary!(item)
            .toLowerCase()
            .contains(searchLower);
        return primaryMatch || secondaryMatch;
      }

      return primaryMatch;
    }).toList();
  }

  void _handleItemsChanged(List<T> selectedItems) {
    widget.selectedItems
      ..clear()
      ..addAll(selectedItems);
    _formFieldState.didChange(List<T>.from(selectedItems));
  }

  PopupPropsMultiSelection<T> _buildPopupProps(
    BuildContext context,
    FormFieldState<List<T>> formState,
  ) {
    return PopupPropsMultiSelection.dialog(
      showSearchBox: true,
      showSelectedItems: true,
      validationBuilder: (context, selectedItems) =>
          _buildValidationSection(context, selectedItems),
      checkBoxBuilder: (context, item, isDisabled, isSelected) =>
          _buildCheckbox(isSelected),
      itemBuilder: (context, item, isDisabled, isSelected) =>
          _buildItem(context, item),
      dialogProps: _buildDialogProps(context),
      searchFieldProps: _buildSearchFieldProps(context),
      emptyBuilder: (context, searchText) =>
          _buildEmptyState(context, searchText),
    );
  }

  Widget _buildValidationSection(BuildContext context, List<T> selectedItems) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.enableOtherOption) ...[
          DropdownOtherOptionField(
            controller: _otherController,
            formKey: _formKey,
            hintText: widget.otherOptionHint,
            validator: DropdownValidators.getDuplicateValidator(
              selectedItems,
              widget.itemAsString,
            ),
            onAddPressed: () => _handleAddCustomItem(selectedItems),
          ),
          Divider(color: AppColors.gray, height: 1),
        ],
        _buildDoneButton(context, selectedItems),
      ],
    );
  }

  void _handleAddCustomItem(List<T> selectedItems) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final text = _otherController.text.trim();
    if (text.isEmpty || widget.createCustomItem == null) return;

    final customItem = widget.createCustomItem!(text);
    selectedItems.add(customItem);
    _otherController.clear();
    _formKey.currentState!.reset();
    setState(() {});
  }

  Widget _buildDoneButton(BuildContext context, List<T> selectedItems) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(10),
        vertical: context.setHeight(10),
      ),
      child: CustomElevatedButton(
        height: context.setHeight(45),
        onPressed: () async {
          _formFieldState.didChange(List<T>.from(selectedItems));
          Navigator.of(context).pop();
          await Future.delayed(const Duration(milliseconds: 100));
          widget.onItemsSelected(selectedItems);
          _otherController.clear();
        },
        buttonLabel: widget.doneButtonText.tr(),
      ),
    );
  }

  Widget _buildCheckbox(bool isSelected) {
    return Checkbox(
      value: isSelected,
      onChanged:  (value) {
      },
      activeColor: AppColors.gradientEnd,
      checkColor: Colors.white,
    );
  }

  Widget _buildItem(BuildContext context, T item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(15),
        vertical: context.setHeight(8),
      ),
      child: Text(
        widget.itemAsString(item),
        style: getRegularStyle(
          color: AppColors.black,
          fontSize: context.setSp(FontSize.s14),
        ),
      ),
    );
  }

  DialogProps _buildDialogProps(BuildContext context) {
    return DialogProps(
      backgroundColor: AppColors.white,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.setWidth(10),
        vertical: context.setHeight(10),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: context.setMinSize(2), color: AppColors.gray),
        borderRadius: BorderRadius.circular(context.setMinSize(5)),
      ),
    );
  }

  TextFieldProps _buildSearchFieldProps(BuildContext context) {
    return TextFieldProps(
      decoration: InputDecoration(
        hintText: widget.searchHintText,
        hintStyle: getRegularStyle(
          color: AppColors.gray[600] ?? AppColors.gray,
          fontSize: context.setSp(FontSize.s12),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.blue,
          size: context.setWidth(30),
        ),
        filled: true,
        fillColor: AppColors.white[400],
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.setWidth(16),
          vertical: context.setHeight(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.setMinSize(25)),
          borderSide: BorderSide.none,
        ),
      ),
      style: getRegularStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s12),
      ),
      cursorColor: AppColors.gradientEnd,
    );
  }

  Widget _buildEmptyState(BuildContext context, String searchText) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: AppColors.gray,
            size: context.setWidth(120),
          ),
          Text(
            "${widget.emptyResultText} $searchText",
            style: getRegularStyle(
              color: AppColors.gray[600] ?? AppColors.gray,
              fontSize: context.setSp(FontSize.s16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownBuilder(BuildContext context, _) {
    return Text(
      widget.hintText.tr(),
      style: getRegularStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s14),
      ),
    );
  }

  DropDownDecoratorProps _buildDecoratorProps(
    BuildContext context,
    bool hasError,
  ) {
    final borderColor = hasError ? AppColors.red : AppColors.black;
    return DropDownDecoratorProps(
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: context.setWidth(25),
                color: widget.prefixIconColor ?? AppColors.black,
              )
            : null,
        border: _buildOutlinedBorder(context, color: borderColor),
        disabledBorder: _buildOutlinedBorder(context, color: borderColor),
        enabledBorder: _buildOutlinedBorder(context, color: borderColor),
        focusedBorder: _buildOutlinedBorder(context, color: borderColor),
        errorBorder: _buildOutlinedBorder(context, color: AppColors.red),
      ),
    );
  }

  Widget _buildErrorText(
    BuildContext context,
    FormFieldState<List<T>> formState,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.setHeight(6),
        left: context.setWidth(12),
      ),
      child: Text(
        formState.errorText!,
        style: getRegularStyle(
          color: AppColors.red,
          fontSize: context.setSp(FontSize.s12),
        ),
      ),
    );
  }

  Widget _buildChipsSection() {
    return Column(
      children: [
        ItemsChips<T>(
          itemAsString: widget.itemAsString,
          selectedItems: widget.selectedItems,
          chipBuilder: widget.chipBuilder,
          onChipDeleted: (item) {
            _formFieldState.didChange(List<T>.from(widget.selectedItems));
            setState(() {});
            widget.onChipDeleted?.call(item);
          },
        ),
        SizedBox(height: context.setHeight(15)),
      ],
    );
  }

  static OutlineInputBorder _buildOutlinedBorder(
    BuildContext context, {
    required Color color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.setMinSize(5)),
      borderSide: BorderSide(color: color, width: context.setWidth(1.2)),
    );
  }
}
