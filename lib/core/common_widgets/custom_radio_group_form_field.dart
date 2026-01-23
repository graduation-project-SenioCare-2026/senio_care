import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class CustomRadioGroupFormField<T> extends StatelessWidget {
  final String titleKey;
  final T? value;
  final Map<T, String> options;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const CustomRadioGroupFormField({
    super.key,
    required this.titleKey,
    required this.value,
    required this.options,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: value,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleKey.tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),

            Row(
              children: options.entries.map((entry) {
                return Row(
                  children: [
                    Radio<T>(
                      value: entry.key,
                      groupValue: value,
                      splashRadius: 0,
                      onChanged: (val) {
                        state.didChange(val);
                        onChanged(val);
                      },
                    ),
                    Text(
                      entry.value.tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s16),
                      ),
                    ),
                    SizedBox(width: context.setWidth(10)),
                  ],
                );
              }).toList(),
            ),

            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: state.hasError
                  ? Padding(
                padding: EdgeInsets.only(
                  top: context.setHeight(4),
                ),
                child: Text(
                  state.errorText!,
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
