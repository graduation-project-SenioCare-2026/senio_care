import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/common_widgets/header_text.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/extension/app_localization_extension.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: context.setHeight(70)),
        HeaderText(
          title: context.locale.welcomeToSenioCare,
          titleSize: FontSize.s32,
          subTitle: context.locale.signInToContinueYourCareJourney,
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
                context
                    .locale
                    .signInWithYourGoogleAccountToAccessPersonalizedCareServices,
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s18),
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: context.setHeight(30)),
              CustomElevatedButton(
                onPressed: () {},
                buttonLabel: context.locale.continueWithGoogle,
                backgroundColor: AppColors.white,
                isText: false,
                buttonIcon: AppIcons.google,
                labelColor: AppColors.black,
              ),
              SizedBox(height: context.setHeight(40)),
            ],
          ),
        ),
      ],
    );
  }
}
