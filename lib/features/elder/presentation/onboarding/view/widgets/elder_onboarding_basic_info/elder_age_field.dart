import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/validator/validator.dart';

class ElderAgeField extends StatelessWidget {
  final TextEditingController controller;

  const ElderAgeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "age".tr(),
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: context.setSp(FontSize.s16),
          ),
        ),
        SizedBox(height: context.setHeight(8)),
        CustomTextFormField(
          controller: controller,
          validator: (value) => Validator.validateAge(value),
          keyboardType: TextInputType.number,
          hintText: "enterAgeHint".tr(),
          hintStyle: getRegularStyle(
            color: AppColors.gray[600] ?? AppColors.gray,
          ),
        ),
        SizedBox(height: context.setHeight(15)),
      ],
    );
  }
}
