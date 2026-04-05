import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(18),
        vertical: context.setHeight(10),
      ),
      child: Row(
        children: [
          Text(
            "reminders".tr(),
            style: getBoldStyle(
              color: AppColors.black,
              fontSize: context.setSp(20),
            ),
          ),
          const Spacer(),

          GradientIconContainer(
            childPadding: 0,
            width: 40,
            height: 40,
            radius: 25,
            child: IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  RoutesNames.addNewMedicineScreen,
                );

                if (context.mounted) {
                  final bloc = context.read<DailyReminderBloc>();
                  final elderId = ProfileManager().selectedElder?.id ?? ProfileManager().elder?.id;
                  if (elderId != null) {
                    bloc.add(GetDailyReminderEvent(elderId, bloc.state.selectedDate));
                  }
                }
              },
              icon: Icon(
                Icons.add,
                size: context.setMinSize(40),
                color: AppColors.white,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
