import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view/widgets/elder_onboarding_basic_info/caregiver_id_card.dart';

class CaregiversSection extends StatelessWidget {
  final TextEditingController controller;
  final List<String> caregiverIds;
  final bool hasCaregiver;
  final Function(String) onAdd;
  final Function(bool?) onChange;

  const CaregiversSection({
    super.key,
    required this.controller,
    required this.caregiverIds,
    required this.hasCaregiver,
    required this.onAdd,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "doYouHaveCaregiver".tr(),
          style: getBoldStyle(color: AppColors.black, fontSize: context.setSp(FontSize.s16)),
        ),
        Row(
          children: [
            Radio<bool>(value: true, groupValue: hasCaregiver, onChanged: onChange, splashRadius: 0),
            Text("yes".tr(), style: getRegularStyle(color: AppColors.black, fontSize: context.setSp(FontSize.s16))),
            SizedBox(width: context.setWidth(20)),
            Radio<bool>(value: false, groupValue: hasCaregiver, onChanged: onChange),
            Text("no".tr(), style: getRegularStyle(color: AppColors.black, fontSize: context.setSp(FontSize.s16))),
          ],
        ),
        if (hasCaregiver) ...[
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                    controller: controller,
                 hintText: "add caregiver id here",
                  hintStyle: getRegularStyle(color: AppColors.gray[600]??AppColors.gray),
                ),
              ),
              IconButton(
                onPressed: () {
                  onAdd(controller.text);
                  controller.clear();
                },
                icon: Icon(Icons.add,color: AppColors.black,size: context.setWidth(30),),
              ),
            ],
          ),
          SizedBox(height: context.setHeight(8)),
          if (caregiverIds.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: caregiverIds.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) => CaregiverIdCard(cardIndex: index, caregiverId: caregiverIds[index]),
            ),
        ],
      ],
    );
  }
}
