import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

import '../../../../../../core/theme/font_manager.dart';
import '../../../view_model/medicine/medicine_bloc.dart';
import '../../../view_model/medicine/medicine_event.dart';

class TimesSection extends StatelessWidget {
  final List<String> times;
  const TimesSection({super.key, required this.times});

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.blue,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.black,
          ),
          dialogBackgroundColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.blue),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {

      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      final formattedTime = '$hour:$minute $period';

      context.read<MedicinesBloc>().add(TimeAdded(formattedTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.setHeight(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray.shade800),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'reminderTimes'.tr(),
                style: getBoldStyle(
                  color: AppColors.black,
                  fontSize: context.setSp(FontSize.s16),
                ),
              ),
              GestureDetector(
                onTap: () => _pickTime(context),
                child: Row(
                  children: [
                    const Icon(Icons.add_alarm, size: 18),
                    SizedBox(width: context.setWidth(4)),
                    Text(
                      'add'.tr(),
                      style: getBoldStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.setHeight(12)),
          if (times.isEmpty)
            Text(
              'noTimesAddedYet'.tr(),
              style: getRegularStyle(color: Colors.grey.shade600),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: times.map((t) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(12),
                    vertical: context.setHeight(8),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t,
                        style: getRegularStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(width: context.setWidth(14)),
                      GestureDetector(
                        onTap: () =>
                            context.read<MedicinesBloc>().add(TimeRemoved(t)),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
