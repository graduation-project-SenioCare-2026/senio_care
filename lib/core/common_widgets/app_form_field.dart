import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final String? suffix;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;

  const AppFormField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.validator,
    this.controller,
    this.autoValidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr(),
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: context.setSp(FontSize.s16),
          ),
        ),
        SizedBox(height: context.setHeight(8)),
        CustomTextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          hintText: hint.tr(),
          hintStyle: getRegularStyle(
            color: AppColors.gray[800] ?? AppColors.gray,
          ),
          autovalidateMode: autoValidateMode,
          suffixIcon: suffix == null
              ? null
              : Text(
            suffix!.tr(),
            style: getRegularStyle(
              color: AppColors.gray[800] ?? AppColors.gray,
              fontSize: context.setSp(FontSize.s14),
            ),
          ),
        ),
        SizedBox(height: context.setHeight(15)),
      ],
    );
  }
}