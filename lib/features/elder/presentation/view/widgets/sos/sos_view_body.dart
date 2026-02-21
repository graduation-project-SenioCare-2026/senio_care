import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/sos/sos_btn.dart';

class SosViewBody extends StatelessWidget {
  const SosViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<CaregiverEntity>? caregivers = ProfileManager().elder?.caregiverIds;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(26)),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "quickHelpWhenYouNeedIt".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s18),
              ),
            ),
            SizedBox(height: context.setHeight(20)),

            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "pressAndHoldTheButtonBelowToAlertYourFamilyMembersInCaseOfEmergency"
                          .tr(),
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s16),
                      ),
                    ),
                    SizedBox(height: context.setHeight(20)),

                    // SOS Button
                    SosBtn(emergencyNumber: '01147124052'),
                    SizedBox(height: context.setHeight(15)),

                    Text(
                      "emergencyContactsWillBeNotified".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(14),
                      ),
                    ),
                    SizedBox(height: context.setHeight(10)),

                    if (caregivers != null && caregivers.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(caregivers.length, (index) {
                          final caregiver = caregivers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: context.setHeight(15),
                                  color: AppColors.black,
                                ),
                                SizedBox(width: context.setWidth(10)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      caregiver.relationship ?? "",
                                      style: getRegularStyle(
                                        color: AppColors.black,
                                        fontSize: context.setSp(14),
                                      ),
                                    ),
                                    Text(
                                      caregiver.phoneNumber ?? "",
                                      style: getRegularStyle(
                                        color: AppColors.black,
                                        fontSize: context.setSp(14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      )
                    else
                      Text(
                        "noEmergencyContacts".tr(),
                        style: getRegularStyle(
                          color: AppColors.white,
                          fontSize: context.setSp(14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.setHeight(70)),
          ],
        ),
      ),
    );
  }
}
