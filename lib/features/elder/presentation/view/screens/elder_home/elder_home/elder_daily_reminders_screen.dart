import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/medicines/presentation/view/widgets/daily_reminders/daily_reminders_view_body.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_bloc.dart';
import 'package:senio_care/features/medicines/presentation/view_model/daily_reminder/daily_reminder_event.dart';

class ElderDailyRemindersScreen extends StatefulWidget {
  const ElderDailyRemindersScreen({super.key});

  @override
  State<ElderDailyRemindersScreen> createState() =>
      _ElderDailyRemindersScreen();
}

class _ElderDailyRemindersScreen extends State<ElderDailyRemindersScreen> {
  final elderId =
      ProfileManager().selectedElder?.id ?? ProfileManager().elder?.id;
  @override
  void initState() {
    super.initState();

    final today = context.read<DailyReminderBloc>().state.selectedDate;

    context.read<DailyReminderBloc>().add(
      GetDailyReminderEvent(elderId!, today),
    );
  }

  void _onDateChanged(DateTime date) {
    final formatted =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    context.read<DailyReminderBloc>().add(
      ChangeDateEvent(date: formatted, elderId: elderId!),
    );
    context.read<DailyReminderBloc>().add(
      GetDailyReminderEvent(elderId!, formatted),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white.withOpacity(0.9)),
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: context.setWidth(25),
              ),
            ),
            title: FittedBox(
              child: Text(
                "medicineSchedule".tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s24),
                ),
              ),
            ),
          ),
          body: DailyRemindersViewBody(onDateChanged: _onDateChanged),
        ),
      ],
    );
  }
}
