import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:senio_care/core/common_widgets/custom_elevated_button.dart';
import 'package:senio_care/core/constants/app_icons.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_event.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_state.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  final String role;
  const ContinueWithGoogleButton({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.loginStatus.isSuccess) {
          Loaders.showSuccessMessage(
            message: "loginSuccess".tr(),
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(context, RoutesNames.elderOnboarding, (route) => false,);
        }
        if (state.loginStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.loginStatus.error!.message,
            context: context,
            secondsDuration: 5,
          );
        }
      },
      builder: (context, state) {
         if(state.loginStatus.isLoading) {
           return LoadingAnimationWidget.flickr(
             leftDotColor:AppColors.gradientEnd ,
             rightDotColor: AppColors.gradientMiddle,
             size: context.setWidth(30),
           );
         }
          return CustomElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignInWithGoogleEvent(role));
            },
            buttonLabel: 'continueWithGoogle'.tr(),
            backgroundColor: AppColors.white,
            isText: false,
            buttonIcon: AppIcons.google,
            labelColor: AppColors.black,
          );

      },
    );
  }
}