import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/auth/presentation/views/widgets/login/continue_with_google_button.dart';

class LoginViewBody extends StatelessWidget {
  final String role;
  const LoginViewBody({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    String loginSubTitle = "signInToContinueYourCareJourney".tr();
    if (role == "caregiver") {
      loginSubTitle = "continueCaregivingJourney".tr();
    } else if (role == "serviceProvider") {
      loginSubTitle = "continueProvidingCareServices".tr();
    } else {
      loginSubTitle = "signInToContinueYourCareJourney".tr();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: context.setWidth(10)),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: context.setWidth(25),
              ),
            ),
          ],
        ),
        SizedBox(height: context.setHeight(10)),
        HeaderText(
          title: 'welcomeToSenioCare'.tr(),
          titleSize: FontSize.s32,
          subTitle: loginSubTitle.tr(),
          subTitleSize: FontSize.s20,
          titlePadding: 20,
        ),
        SizedBox(height: context.setHeight(50)),
        BlurContainer(
          child: Column(
            children: [
              GradientIconContainer(
                width: 80,
                height: 85,
                radius: 90,
                child: Image.asset(
                  AppIcons.profileOutline,
                  height: context.setHeight(50),
                  width: context.setWidth(50),
                ),
              ),
              SizedBox(height: context.setHeight(10)),
              Text(
                'signInWithYourGoogleAccountToAccessPersonalizedCareServices'
                    .tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s18),
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: context.setHeight(30)),
              ContinueWithGoogleButton(role: role),
              SizedBox(height: context.setHeight(40)),
            ],
          ),
        ),
      ],
    );
  }
}
