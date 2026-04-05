import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

import '../../../../../../core/theme/font_manager.dart';
import '../../../view_model/medicine/medicine_bloc.dart';
import '../../../view_model/medicine/medicine_event.dart';

class StartDateField extends StatelessWidget {
  final DateTime startDate;
  const StartDateField({super.key, required this.startDate});

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
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
      context.read<MedicinesBloc>().add(StartDateChanged(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM yyyy');
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(16),
          vertical: context.setHeight(14),
        ),
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
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey.shade500, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'startDate'.tr(),
                    style: getRegularStyle(
                      color: Colors.grey.shade500,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                  SizedBox(height: context.setHeight(2)),
                  Text(
                    fmt.format(startDate),
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s13),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}
