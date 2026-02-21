import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/avatar_container.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/caregiver_edit_card.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/views/widgets/edit_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class CaregiverEditProfileBody extends StatelessWidget {
  const CaregiverEditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaregiverEditProfileBloc,CaregiverEditProfileState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Skeletonizer(
            enabled: state.getCaregiverProfileState.isLoading,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    "editProfile".tr(),
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s30),
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: context.setWidth(25),
                    ),
                  ),
                ),
                AvatarContainer(),
                CaregiverEditCard(),
                EditCaregiverButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
