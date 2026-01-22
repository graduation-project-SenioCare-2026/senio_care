import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';

class BloodTypePicker extends StatefulWidget {
  final BloodTypeEntity? selectedBloodType;
  final List<BloodTypeEntity> bloodTypes;
  final Function(BloodTypeEntity) onSelected;

  const BloodTypePicker({
    super.key,
    required this.selectedBloodType,
    required this.bloodTypes,
    required this.onSelected,
  });

  @override
  State<BloodTypePicker> createState() => _BloodTypePickerState();
}

class _BloodTypePickerState extends State<BloodTypePicker> {
  final GlobalKey<FormFieldState<BloodTypeEntity>> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FormField<BloodTypeEntity>(
      key: _fieldKey,
      initialValue: widget.selectedBloodType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) return "requiredField".tr();
        return null;
      },
      builder: (formState) {
        final hasError = formState.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                BloodTypeEntity? selected = await showDialog<BloodTypeEntity>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: AppColors.gray, width: 1.2),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.bloodtype, size: 25, color: AppColors.gradientEnd),
                        SizedBox(width: 10),
                        Text(
                          "selectBloodType".tr(),
                          style: getRegularStyle(
                            color: AppColors.gradientEnd,
                            fontSize: context.setSp(FontSize.s20),
                          ),
                        ),
                      ],
                    ),
                    content: SizedBox(
                      width: double.minPositive,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.bloodTypes.length,
                        itemBuilder: (context, index) {
                          final bt = widget.bloodTypes[index];
                          return ListTile(
                            title: Text(
                              bt.type,
                              style: getRegularStyle(
                                color: AppColors.black,
                                fontSize: context.setSp(FontSize.s16),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(bt),
                          );
                        },
                      ),
                    ),
                  ),
                );

                if (selected != null) {
                  formState.didChange(selected);
                  widget.onSelected(selected);
                  setState(() {});
                }
              },
              child: Container(
                width: context.setWidth(300),
                height: context.setHeight(55),
                padding: EdgeInsets.symmetric(
                  vertical: context.setHeight(16),
                  horizontal: context.setWidth(12),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: hasError ? AppColors.red : AppColors.black,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.bloodtype, size: 25, color: AppColors.black),
                    SizedBox(width: 12),
                    Text(
                      formState.value?.type ?? "selectBloodType".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s14),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down, size: 25, color: AppColors.black),
                  ],
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: EdgeInsets.only(top: context.setHeight(6), left: context.setWidth(12)),
                child: Text(
                  formState.errorText!,
                  style: getRegularStyle(
                    color: AppColors.red,
                    fontSize: context.setSp(FontSize.s12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
