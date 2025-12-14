
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
    final TextEditingController internalController =
        controller ?? TextEditingController(text: initialValue);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: onTap,
        style:
        style ??
            getRegularStyle(
              color: AppColors.black,
              fontSize: context.setSp(FontSize.s16),
            ),
        controller: internalController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        textInputAction: textInputAction,
        readOnly: isReadOnly ?? false,
        decoration: InputDecoration(
          floatingLabelBehavior: floatingLabelBehavior,
          contentPadding:
          contentPadding ??
              EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(4),
              ),
          filled: isReadOnly,
          fillColor: isReadOnly == true
              ? AppColors.gray[10]?.withAlpha(50)
              : null,
          label: FittedBox(
              fit: BoxFit.scaleDown,
              child:( label!=null)? Text(
                label!,
                style:
                labelStyle ??
                    getRegularStyle(
                      color: AppColors.gray,
                      fontSize: context.setSp(FontSize.s12),
                    ),
              )
                  :null
          ),
          hintStyle:
          hintStyle ??
              getRegularStyle(
                color: AppColors.gray,
                fontSize: context.setSp(FontSize.s12),
              ),
          hintText: hintText,

          focusedBorder: buildOutlinedBorder(
            context: context,
            borderColor:AppColors.black,
            borderRadius: context.setWidth(5),
          ),
          enabledBorder: buildOutlinedBorder(
            context: context,
            borderColor: AppColors.black,
            borderRadius: context.setWidth(5),
          ),
          focusedErrorBorder: buildOutlinedBorder(
            context: context,
            borderColor: AppColors.red,
            borderRadius: context.setWidth(5),
          ),
          errorBorder: buildOutlinedBorder(
            context: context,
            borderColor: AppColors.red,
            borderRadius: context.setWidth(5),
          ),
          disabledBorder: buildOutlinedBorder(
            context: context,
            borderColor:
            AppColors.black,
            borderRadius: context.setWidth(5),
          ),
          prefixIcon: Padding(
            padding:  EdgeInsets.only(left: context.setWidth(16), right: context.setWidth(8)),
            child: prefixIcon,
          ),
          prefixIconConstraints:
          prefixIconConstraints ??
              BoxConstraints(
                maxWidth: context.setWidth(60),
                maxHeight: context.setHeight(60),
              ),
          suffixIconConstraints:
          suffixIconConstraints ??
              BoxConstraints(
                maxWidth: context.setWidth(60),
                maxHeight: context.setHeight(60),
              ),
          suffixIcon: Padding(
            padding:  EdgeInsets.only(left: context.setWidth(16), right: context.setWidth(8)),
            child: suffixIcon,
          ),
          errorStyle: getRegularStyle(color: AppColors.red),
          errorMaxLines: 3,
        ),
        maxLength: maxLength,
        onChanged: onChanged,
        onSaved: onSaved,
        maxLines: maxLines,
        validator: validator,
        enabled: enabled,
      ),
    );
  }

  static OutlineInputBorder buildOutlinedBorder({
    required BuildContext context,
    required Color borderColor,
    required double borderRadius,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.setMinSize(borderRadius)),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
