import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';

import '../../../view_model/medicine/medicine_bloc.dart';
import '../../../view_model/medicine/medicine_event.dart';
import '../../../view_model/medicine/medicine_state.dart';

class EndDateField extends StatelessWidget {
  final MedicinesState state;
  final DateTime startDate;
  const EndDateField({super.key, required this.state, required this.startDate});

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: state.effectiveEndDate,
      firstDate: startDate,
      lastDate: startDate.add(const Duration(days: 365 * 5)),
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
      context.read<MedicinesBloc>().add(EndDateChanged(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPicked = state.endDate != null;
    final fmt = DateFormat('dd MMM yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
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
                Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                SizedBox(width: context.setWidth(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userPicked
                            ? 'endDate'.tr()
                            : 'endDate(default+3Months)'.tr(),
                        style: getRegularStyle(
                          color: Colors.grey.shade500,
                          fontSize:  context.setSp(FontSize.s14),
                        ),
                      ),
                      SizedBox(height: context.setHeight(2)),
                      Text(
                        fmt.format(state.effectiveEndDate),
                        style: getBoldStyle(
                          color: userPicked
                              ? AppColors.black
                              : Colors.grey.shade400,
                          fontSize:  context.setSp(FontSize.s13),
                        ),
                      ),
                    ],
                  ),
                ),
                if (userPicked)
                  GestureDetector(
                    onTap: () =>
                        context.read<MedicinesBloc>().add(EndDateChanged(null)),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  )
                else
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
        if (!userPicked)
          Padding(
            padding: EdgeInsets.only(
              top: context.setHeight(4),
              left: context.setWidth(12),
            ),
            child: Text(
              'autoSetTo3MonthsFromStartDateIfNotChosen'.tr(),
              style: getRegularStyle(
                color: Colors.grey.shade500,
                fontSize: context.setSp(FontSize.s12),
              ),
            ),
          ),
      ],
    );
  }
}
