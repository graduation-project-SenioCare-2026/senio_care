import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_style.dart';
import '../../../../../../domain/entity/time_slot_entity.dart';
import '../../view_model/services_bloc.dart';
import '../../view_model/services_event.dart';
import '../../view_model/services_state.dart';
import 'day_card.dart';

class AddDaySection extends StatefulWidget {
  const AddDaySection({super.key});

  @override
  State<AddDaySection> createState() => _AddDaySectionState();
}

class _AddDaySectionState extends State<AddDaySection> {
  final List<String> _selectedDays = [];

  static const List<String> _allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  void _showDayPicker() {
    final available = _allDays
        .where((d) => !_selectedDays.contains(d))
        .toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All days have been added!')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select a Day',
                style: getBoldStyle(color: AppColors.black, fontSize: 16),
              ),
            ),
            ...available.map(
              (day) => ListTile(
                title: Text(day),
                onTap: () {
                  setState(() => _selectedDays.add(day));
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _removeDay(String day) {
    setState(() => _selectedDays.remove(day));
    context.read<ServicesBloc>().add(RemoveDayEvent(day));
  }

  void _showTimeSlotPicker(String day) {
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Add Time Slot',
            style: getBoldStyle(color: AppColors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Start time picker
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: ctx,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setDialogState(() => startTime = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        startTime == null ? '--:-- --' : startTime!.format(ctx),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Icon(Icons.access_time, color: Colors.grey.shade500),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('to', style: getBoldStyle(color: AppColors.black)),
              const SizedBox(height: 12),
              // End time picker
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: ctx,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setDialogState(() => endTime = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        endTime == null ? '--:-- --' : endTime!.format(ctx),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Icon(Icons.access_time, color: Colors.grey.shade500),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: startTime != null && endTime != null
                  ? () {
                      context.read<ServicesBloc>().add(
                        AddTimeSlotEvent(
                          day: day,
                          slot: TimeSlot(
                            startTime: startTime!.format(ctx),
                            endTime: endTime!.format(ctx),
                          ),
                        ),
                      );
                      Navigator.pop(ctx);
                    }
                  : null,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "schedules&Days".tr(),
                  style: getBoldStyle(
                    color: AppColors.black,
                    fontSize: context.setSp(15),
                  ),
                ),
                GestureDetector(
                  onTap: _showDayPicker,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: context.setHeight(7),
                      horizontal: context.setWidth(7),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        width: 2,
                        color: AppColors.gray.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 18),
                        SizedBox(width: context.setWidth(4)),
                        Text(
                          "addDay".tr(),
                          style: getBoldStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ..._selectedDays.map(
              (day) => DayScheduleCard(
                key: ValueKey(day),
                day: day,
                slots: state.availability[day] ?? [],
                onDelete: () => _removeDay(day),
                onAddSlot: () => _showTimeSlotPicker(day),
              ),
            ),
            if (_selectedDays.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
                child: Center(
                  child: Text(
                    'noDaysAddedYet'.tr(),
                    style: getRegularStyle(
                      color: Colors.grey.shade400,
                      fontSize: context.setSp(12),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
