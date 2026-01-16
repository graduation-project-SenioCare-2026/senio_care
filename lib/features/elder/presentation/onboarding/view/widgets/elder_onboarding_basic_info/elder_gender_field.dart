import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/validator/validator.dart';

class ElderGenderField extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const ElderGenderField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedGender,
      validator: (value) => Validator.validateGender(value),
      builder: (stateGender) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "gender".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            Row(
              children: [
                Radio<String>(
                  value: "male",
                  groupValue: selectedGender,
                  onChanged: (value) => onChanged(value),
                  splashRadius: 0,
                ),
                Text(
                  "male".tr(),
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s16),
                  ),
                ),
                SizedBox(width: context.setWidth(10)),
                Radio<String>(
                  value: "female",
                  groupValue: selectedGender,
                  onChanged: (value) => onChanged(value),
                ),
                Text(
                  "female".tr(),
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(FontSize.s16),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: stateGender.hasError
                  ? Padding(
                      padding: EdgeInsets.only(top: context.setHeight(4)),
                      child: Text(
                        stateGender.errorText!,
                        style: getRegularStyle(
                          color: Colors.red,
                          fontSize: context.setSp(FontSize.s12),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: context.setHeight(10)),
          ],
        );
      },
    );
  }
}
