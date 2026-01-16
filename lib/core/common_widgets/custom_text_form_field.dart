import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.validator,
    this.textInputAction,
    this.hintStyle,
    this.contentPadding,
    this.style,
    this.onTap,
    this.enabled,
    this.suffixIconConstraints,
    this.maxLength,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.label,
    this.labelStyle,
    this.borderRadius = 0,
    this.disabledBorderColor,
    this.isReadOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });

  final String? initialValue;
  final String? hintText;
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final void Function()? onTap;
  final bool? enabled;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLength;
  final double borderRadius;
  final Color? disabledBorderColor;
  final bool? isReadOnly;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    // لو في controller استخدمه، وإلا انشئ واحد فارغ
    final TextEditingController internalController =
        controller ?? TextEditingController();

    // لو في initialValue وما في نص موجود بالفعل
    if (initialValue != null && internalController.text.isEmpty) {
      internalController.text = initialValue!;
    }

    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.gray[300],
          selectionHandleColor: AppColors.blue[300],
        ),
      ),
      child: SizedBox(
        height: context.setHeight(40),
        child: TextFormField(
          controller: internalController,
          onTap: onTap,
          cursorColor: AppColors.gray[600],
          selectionControls: materialTextSelectionControls,
          style: style ??
              getRegularStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s18),
              ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          textInputAction: textInputAction,
          readOnly: isReadOnly ?? false,
          maxLength: maxLength,
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          enabled: enabled,
          decoration: InputDecoration(
            floatingLabelBehavior: floatingLabelBehavior,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: context.setWidth(8)),
            filled: isReadOnly,
            fillColor:isReadOnly == true ? AppColors.gray[10]?.withAlpha(50) : null,
            label: label != null
                ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label!,
                style: labelStyle ??
                    getRegularStyle(
                      color: AppColors.gray,
                      fontSize: context.setSp(FontSize.s12),
                    ),
              ),
            )
                : null,
            hintText: hintText,
            hintStyle: hintStyle ??
                getRegularStyle(
                  color: AppColors.gray,
                  fontSize: context.setSp(FontSize.s12),
                ),
            focusedBorder: buildOutlinedBorder(context, AppColors.black),
            enabledBorder: buildOutlinedBorder(context, AppColors.black),
            focusedErrorBorder: buildOutlinedBorder(context, AppColors.red),
            errorBorder: buildOutlinedBorder(context, AppColors.red),
            disabledBorder: buildOutlinedBorder(context, AppColors.black),
            prefixIcon: prefixIcon != null
                ? Padding(
              padding: EdgeInsets.only(left: context.setWidth(16), right: context.setWidth(8)),
              child: prefixIcon,
            )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
              padding: EdgeInsets.only(left: context.setWidth(16), right: context.setWidth(8)),
              child: suffixIcon,
            )
                : null,
            prefixIconConstraints: prefixIconConstraints ?? const BoxConstraints(),
            suffixIconConstraints: suffixIconConstraints ?? const BoxConstraints(),
            errorStyle: getRegularStyle(color: AppColors.red),
            errorMaxLines: 3,
          ),
        ),
      ),
    );
  }

  static OutlineInputBorder buildOutlinedBorder(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.setMinSize(5)),
      borderSide: BorderSide(color: color),
    );
  }
}
