import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class ItemsChips<T> extends StatefulWidget {
  final String Function(T) itemAsString;
  final Function(T)? onChipDeleted;
  final List<T> selectedItems;
  final Widget Function(BuildContext, T)? chipBuilder;

  const ItemsChips({
    required this.selectedItems,
    required this.itemAsString,
    this.chipBuilder,
    this.onChipDeleted,
    super.key,
  });

  @override
  State<ItemsChips<T>> createState() => _ItemsChipsState<T>();
}

class _ItemsChipsState<T> extends State<ItemsChips<T>> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.setWidth(5),
      runSpacing: context.setHeight(-8),
      children: widget.selectedItems.map((item) {
        if (widget.chipBuilder != null) {
          return widget.chipBuilder!(context, item);
        }

        return Chip(
          label: Text(
            widget.itemAsString(item),
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s12),
            ),
          ),
          deleteIcon: Icon(
            Icons.cancel,
            color: AppColors.gradientEnd,
            size: context.setWidth(20),
          ),
          onDeleted: widget.onChipDeleted != null
              ? () {
            // Remove item from the list
            widget.selectedItems.remove(item);
            // Call the callback first (which updates parent state)
            widget.onChipDeleted!(item);
            // Trigger rebuild of this widget
            setState(() {});
          }
              : null,
          backgroundColor: AppColors.gradientEnd.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.setMinSize(25)),
            side: BorderSide(
              color: AppColors.gradientEnd,
              width: context.setWidth(1),
            ),
          ),
          labelPadding: EdgeInsets.symmetric(
            horizontal: context.setWidth(5),
            vertical: context.setHeight(0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(5),
            vertical: context.setHeight(5),
          ),
        );
      }).toList(),
    );
  }
}