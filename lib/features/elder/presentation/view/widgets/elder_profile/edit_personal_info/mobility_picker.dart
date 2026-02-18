import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

class MobilityStatusPicker extends StatefulWidget {
  final MobilityStatusEntity? selectedStatus;
  final List<MobilityStatusEntity> statuses;
  final Function(MobilityStatusEntity) onSelected;

  const MobilityStatusPicker({
    super.key,
    required this.selectedStatus,
    required this.statuses,
    required this.onSelected,
  });

  @override
  State<MobilityStatusPicker> createState() => _MobilityStatusPickerState();
}

class _MobilityStatusPickerState extends State<MobilityStatusPicker> {
  final GlobalKey<FormFieldState<MobilityStatusEntity>> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FormField<MobilityStatusEntity>(
      key: _fieldKey,
      initialValue: widget.selectedStatus,
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
                MobilityStatusEntity? selected =
                    await showDialog<MobilityStatusEntity>(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: AppColors.gray, width: 1.2),
                        ),
                        title: Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              "selectMobilityStatus".tr(),
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
                            itemCount: widget.statuses.length,
                            itemBuilder: (context, index) {
                              final status = widget.statuses[index];
                              return ListTile(
                                title: Text(
                                  status.en,
                                  style: getRegularStyle(
                                    color: AppColors.black,
                                    fontSize: context.setSp(FontSize.s16),
                                  ),
                                ),
                                onTap: () => Navigator.of(context).pop(status),
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
                    Text(
                      formState.value?.en ?? "selectMobilityStatus".tr(),
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
