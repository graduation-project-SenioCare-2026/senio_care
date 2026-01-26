import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_event.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.read<AuthBloc>().add(InitSessionEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state.loginStatus.isFailure) {
          Navigator.pushReplacementNamed(context, RoutesNames.rolesScreen);
        } else if (state.getElderStatus.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.elderHome);
        } else if (state.getCaregiverStatus.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.caregiverHome);
        } else if (state.getServiceProviderStatus.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.serviceProviderHome);
        }
      },
      builder: (context, state) {
        return AuthBg(
          blur: 2,
          blurAlpha: 100,
          midGradientColor: AppColors.black,
          midGradientAlpha: 50,
          child: Column(
            children: [
              SizedBox(height: context.setHeight(270)),
              Center(
                child: Text(
                  "senioCare".tr(),
                  style: getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s44),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}