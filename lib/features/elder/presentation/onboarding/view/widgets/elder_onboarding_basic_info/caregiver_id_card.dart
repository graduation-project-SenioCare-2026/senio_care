import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';

class CaregiverIdCard extends StatelessWidget {
  final int cardIndex;
  final String caregiverId;
  const CaregiverIdCard({required this.cardIndex,required this.caregiverId,super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blue.withAlpha(80),
            child: Text(
                '${cardIndex + 1}',
                style:getBoldStyle(color: AppColors.blue,fontSize: context.setSp(FontSize.s18))
            ),
          ),

          SizedBox(width: context.setWidth(12)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'caregiverId'.tr(),
                    style:getRegularStyle(color: AppColors.blue,fontSize: context.setSp(FontSize.s14))

                ),
                SizedBox(height: context.setHeight(4)),
                Text(
                    caregiverId,
                    style:getRegularStyle(color: AppColors.black,fontSize: context.setSp(FontSize.s14))

                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              context
                  .read<ElderOnboardingBloc>()
                  .add(RemoveCareGiverEvent(cardIndex));
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );;
  }
}
