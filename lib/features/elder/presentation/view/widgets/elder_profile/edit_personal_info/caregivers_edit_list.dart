import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';

class CaregiversList extends StatelessWidget {
  final List caregivers;

  const CaregiversList({super.key, required this.caregivers});

  @override
  Widget build(BuildContext context) {
    if (caregivers.isEmpty) {
      return Text(
        "noCaregiversProvided".tr(),
        style: getRegularStyle(
          color: AppColors.gray[700] ?? AppColors.gray,
          fontSize: FontSize.s14,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: caregivers.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: context.setHeight(8)),
      itemBuilder: (context, index) {
        final caregiver = caregivers[index];

        return Chip(
          label: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((caregiver.relationship ?? "").isNotEmpty)
                    Text(
                      caregiver.relationship!,
                      style: getRegularStyle(
                        color: AppColors.blue,
                        fontSize: context.setSp(FontSize.s14),
                      ),
                    ),
                  Text(
                    caregiver.id ?? "",
                    style: getRegularStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                ],
              ),
            ],
          ),
          deleteIcon: Icon(
            Icons.cancel,
            color: AppColors.gradientEnd,
            size: context.setWidth(25),
          ),
          onDeleted: () {
            context.read<ElderProfileBloc>().add(
              RemoveCaregiverEvent(caregiver.id!),
            );
          },
          backgroundColor: AppColors.gradientEnd.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(context.setMinSize(20)),
            side: BorderSide(
              color: AppColors.gradientEnd,
              width: context.setWidth(1),
            ),
          ),
          labelPadding: EdgeInsets.symmetric(
            horizontal: context.setWidth(5),
            vertical: context.setHeight(0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(10),
            vertical: context.setHeight(5),
          ),
        );
      },
    );
  }
}
