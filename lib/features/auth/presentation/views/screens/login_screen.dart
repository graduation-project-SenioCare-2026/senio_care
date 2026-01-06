import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/auth/presentation/views/widgets/login/login_view_body.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  const LoginScreen({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBg(
      blur: 2,
      blurAlpha: 100,
      midGradientColor: AppColors.white,
      midGradientAlpha: 30,
      child: LoginViewBody(),
    );
  }
}
