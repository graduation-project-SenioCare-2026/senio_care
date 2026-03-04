import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../../../../../domain/entity/availability_entity.dart';

class AvailabilityRow extends StatelessWidget {
  final AvailabilityEntity availability;

  const AvailabilityRow({super.key, required this.availability});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.setHeight(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day chip
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.setWidth(10),
              vertical: context.setHeight(5),
            ),
            decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              availability.day,
              style: getBoldStyle(color: AppColors.blue, fontSize: 12),
            ),
          ),
          SizedBox(width: context.setWidth(10)),

          // Time slots
          Expanded(
            child: availability.time.isEmpty
                ? Text(
              'noSlots'.tr(),
              style: getRegularStyle(color: Colors.grey.shade500),
            )
                : Wrap(
              spacing: context.setWidth(6),
              runSpacing: context.setHeight(6),
              children: availability.time.map((slot) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(8),
                    vertical: context.setHeight(4),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    '${slot.startTime} - ${slot.endTime}',
                    style: getRegularStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}