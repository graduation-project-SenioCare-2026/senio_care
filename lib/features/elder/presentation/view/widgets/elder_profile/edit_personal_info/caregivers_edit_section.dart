import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class CaregiversEditSection extends StatelessWidget {
  const CaregiversEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "caregivers".tr(),
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s16),
              ),
            ),
            SizedBox(height: context.setHeight(8),),

          ],
        );
      },
    );
  }
}
