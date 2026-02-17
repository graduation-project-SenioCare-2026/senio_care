import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/avatar_container.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/caregiver_profile_body.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/elder_id_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/constants/app_icons.dart';
import '../../../../../../../../core/routes/routes_names.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../../../core/user/profile_manager.dart';
import '../../../../../../../../core/user/user_manager.dart';
import '../widgets/info_raw.dart';

class CaregiverProfileTab extends StatelessWidget {
  const CaregiverProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    final caregiverId = ProfileManager().caregiver?.id ?? UserManager().user?.id;

    // Handle null case
    if (caregiverId == null) {
      return Scaffold(
        body: Center(
          child: Text("caregiver_not_found".tr()),
        ),
      );
    }
    return BlocProvider(
      create: (context) =>
          getIt<CaregiverEditProfileBloc>()..add(GetCaregiverByIdEvent(caregiverId)),
      child: CaregiverProfileBody(),
    );
  }
}
