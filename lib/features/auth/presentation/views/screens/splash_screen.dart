import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/auth_bg.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';
import 'package:senio_care/features/auth/presentation/view_model/user_session_view_model/user_session_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _shimmerController;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade in the text first
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Shimmer sweeps across after fade
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Start fade, then shimmer
    _fadeController.forward().then((_) {
      _shimmerController.forward();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.read<SessionBloc>().add(InitSessionEvent());
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (!state.sessionChecked) return;

        if (state.elderStatus.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.elderHome);
        } else if (state.caregiverStatus.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutesNames.caregiverHome);
        } else if (state.serviceProviderStatus.isSuccess) {
          Navigator.pushReplacementNamed(
              context, RoutesNames.serviceProviderHome);
        } else {
          Navigator.pushReplacementNamed(context, RoutesNames.rolesScreen);
        }
      },
      child: AuthBg(
        blur: 2,
        blurAlpha: 100,
        midGradientColor: AppColors.black,
        midGradientAlpha: 50,
        child: Column(
          children: [
            SizedBox(height: context.setHeight(270)),
            FadeTransition(
              opacity: _fadeAnimation,
              child: AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      final shimmerPosition = _shimmerController.value;

                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: const [
                          Colors.white,
                          Colors.white,
                          Color(0xFFFFFFFF),
                          Color(0xCCFFFFFF),
                          Colors.white70,
                          Colors.white,
                          Colors.white,
                        ],
                        stops: [
                          0.0,
                          (shimmerPosition - 0.3).clamp(0.0, 1.0),
                          (shimmerPosition - 0.1).clamp(0.0, 1.0),
                          shimmerPosition.clamp(0.0, 1.0),
                          (shimmerPosition + 0.1).clamp(0.0, 1.0),
                          (shimmerPosition + 0.3).clamp(0.0, 1.0),
                          1.0,
                        ],
                      ).createShader(bounds);
                    },
                    child: child,
                  );
                },
                child: Text(
                  "senioCare".tr(),
                  style: getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s44),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}