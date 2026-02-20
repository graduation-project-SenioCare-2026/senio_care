import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/add_caregiver_row.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/edit_personal_info/caregivers_edit_list.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class CaregiversEditSection extends StatefulWidget {
  final dynamic elder;

  const CaregiversEditSection({super.key, required this.elder});

  @override
  State<CaregiversEditSection> createState() => _CaregiversEditSectionState();
}

class _CaregiversEditSectionState extends State<CaregiversEditSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElderProfileBloc, ElderProfileState>(
      buildWhen: (prev, curr) => prev.caregivers != curr.caregivers,
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
            SizedBox(height: context.setHeight(8)),
            AddCaregiverRow(formKey: _formKey, state: state),
            SizedBox(height: context.setHeight(8)),
            CaregiversList(caregivers: state.caregivers),
          ],
        );
      },
    );
  }
}