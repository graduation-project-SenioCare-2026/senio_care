import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/validator/validator.dart';

class MedicineTypePicker extends StatefulWidget {
  final String? selectedType;
  final List<String> types;
  final Function(String) onSelected;

  const MedicineTypePicker({
    super.key,
    required this.selectedType,
    required this.types,
    required this.onSelected,
  });

  @override
  State<MedicineTypePicker> createState() => _MedicineTypePickerState();
}

class _MedicineTypePickerState extends State<MedicineTypePicker> {
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _fieldKey,
      initialValue: widget.selectedType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => Validator.validateRequired(value),
      builder: (formState) {
        final hasError = formState.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                String? selected = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: AppColors.gray),
                    ),
                    title: Row(
                      children: [
                        Icon(
                          Icons.medication,
                          size: 25,
                          color: AppColors.gradientEnd,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "selectType".tr(),
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
                        itemCount: widget.types.length,
                        itemBuilder: (context, index) {
                          final type = widget.types[index];
                          return ListTile(
                            title: Text(
                              type,
                              style: getRegularStyle(
                                color: AppColors.black,
                                fontSize: context.setSp(FontSize.s16),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(type),
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
                width: double.infinity,
                height: context.setHeight(55),
                padding: EdgeInsets.symmetric(
                  vertical: context.setHeight(16),
                  horizontal: context.setWidth(12),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: hasError ? AppColors.red : AppColors.black,

                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.medication, size: 25, color: AppColors.black),
                    SizedBox(width: 12),
                    Text(
                      formState.value ?? "selectType".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s14),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
            ),
            if (hasError)
              Padding(
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
              ),
          ],
        );
      },
    );
  }
}
