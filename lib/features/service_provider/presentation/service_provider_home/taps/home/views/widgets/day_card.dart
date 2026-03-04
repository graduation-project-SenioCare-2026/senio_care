import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';

import '../../../../../../domain/entity/time_slot_entity.dart';
import '../../view_model/services_bloc.dart';
import '../../view_model/services_event.dart';

class DayScheduleCard extends StatelessWidget {
  final String day;
  final List<TimeSlot> slots;
  final VoidCallback onDelete;
  final VoidCallback onAddSlot;

  const DayScheduleCard({
    super.key,
    required this.day,
    required this.slots,
    required this.onDelete,
    required this.onAddSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.setHeight(15)),
      padding: EdgeInsets.all(context.setWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
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
          // Day header row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(12),
                    vertical: context.setHeight(10),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(day, style: getBoldStyle(color: AppColors.black)),
                ),
              ),
              SizedBox(width: context.setWidth(10)),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: context.setHeight(15)),
          // Time slots header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "timeSlots".tr(),
                style: getBoldStyle(color: AppColors.black),
              ),
              GestureDetector(
                onTap: onAddSlot,
                child: Row(
                  children: [
                    const Icon(Icons.add, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "addSlot".tr(),
                      style: getBoldStyle(color: AppColors.black, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.setHeight(13)),
          // Show placeholder if no slots, otherwise list each slot
          if (slots.isEmpty)
            _buildSlotRow(context)
          else
            ...slots.map((slot) => Padding(
              padding: EdgeInsets.only(bottom: context.setHeight(8)),
              child: Row(
                children: [
                  Expanded(child: _buildTimeChip(slot.startTime)),
                  const SizedBox(width: 8),
                  Text("to".tr()),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTimeChip(slot.endTime)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => context.read<ServicesBloc>().add(
                      RemoveTimeSlotEvent(day: day, slot: slot),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildSlotRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildTimeChip('--:--')),
        const SizedBox(width: 10),
        Text("to".tr()),
        const SizedBox(width: 10),
        Expanded(child: _buildTimeChip('--:--')),
      ],
    );
  }

  Widget _buildTimeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(time, style: TextStyle(color: Colors.grey.shade600)),
    );
  }
}