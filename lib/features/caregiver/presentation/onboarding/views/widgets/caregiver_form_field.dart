import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

class CaregiverFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelKey;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;


  const CaregiverFormField({
    required this.controller,
    required this.labelKey,
    required this.validator,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelKey.tr(),
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: context.setSp(FontSize.s18),
          ),
          textAlign: TextAlign.start,
        ),
        CustomTextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType,
        ),
        SizedBox(height: context.setHeight(15)),
      ],
    );
  }
}
