import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/caregiver_edit_profile_body.dart';

import '../../../../../../../../config/di/di.dart';
import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';

class CaregiverEditProfile extends StatelessWidget {
  const CaregiverEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child:  BlocProvider(
            create: (context) =>
            getIt<CaregiverEditProfileBloc>()
              ..add(CaregiverInitProfileDataEvent()),
            child: CaregiverEditProfileBody(),
          ),
        ),
      ],
    );
  }
}
