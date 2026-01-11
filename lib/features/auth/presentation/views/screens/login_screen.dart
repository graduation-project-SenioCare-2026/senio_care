import 'package:flutter/material.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/views/widgets/login/login_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocProvider(
        create: (_) => getIt<AuthBloc>(),
        child: LoginViewBody(role: role),
      ),
    );
  }
}
