import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/edit_personal_info_view_body.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_onboarding/elder_onboarding_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ElderOnboardingBloc>()),
              BlocProvider(
                create: (context) => getIt<ElderProfileBloc>()
                  ..add(
                    GetElderEvent(
                      ProfileManager().selectedElder?.id ??
                          ProfileManager().elder!.id!,
                    ),
                  ) // API data
                  ..add(InitElderProfileEvent()), // local form setup
                child: const EditPersonalInfoViewBody(),
              ),
            ],
            child: EditPersonalInfoViewBody(),
          ),
        ),
      ],
    );
  }
}
