import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import '../../../../../../domain/entity/time_slot_entity.dart';
import '../../view_model/services_bloc.dart';
import '../../view_model/services_event.dart';
import '../../view_model/services_state.dart';
import 'day_card.dart';

class AddDaySection extends StatefulWidget {
  final List<String> initialDays;
  const AddDaySection({super.key, this.initialDays = const []});

  @override
  State<AddDaySection> createState() => _AddDaySectionState();
}

class _AddDaySectionState extends State<AddDaySection> {
  late List<String> _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = List<String>.from(widget.initialDays);
  }

  static  final List<String> _allDays = [
    'monday'.tr(),
    'tuesday'.tr(),
    'wednesday'.tr(),
    'thursday'.tr(),
    'friday'.tr(),
    'saturday'.tr(),
    'sunday'.tr(),
  ];

  Widget _timePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: AppColors.blue,
          onPrimary: Colors.white,
          onSurface: AppColors.black,
          surface: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.blue),
        ),
      ),
      child: child!,
    );
  }

  void _showDayPicker() {
    final available =
    _allDays.where((d) => !_selectedDays.contains(d)).toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('allDaysHaveBeenAdded!'.tr()),
      ));
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
                'selectADay'.tr(),
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
      useRootNavigator: true,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
           backgroundColor: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'addTimeSlot'.tr(),
            style: getBoldStyle(color: AppColors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Start time
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    useRootNavigator: true,
                    builder: _timePickerTheme,
                  );
                  if (picked != null) {
                    setDialogState(() => startTime = picked);
                  }
                },
                child: _timeBox(
                  time: startTime,
                  ctx: dialogContext,
                  isSelected: startTime != null,
                ),
              ),
              SizedBox(height: context.setHeight(12)),
              Text('to'.tr(), style: getBoldStyle(color: AppColors.black)),
              SizedBox(height: context.setHeight(12)),
              // End time
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    useRootNavigator: true,
                    builder: _timePickerTheme,
                  );
                  if (picked != null) {
                    setDialogState(() => endTime = picked);
                  }
                },
                child: _timeBox(
                  time: endTime,
                  ctx: dialogContext,
                  isSelected: endTime != null,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: AppColors.blue),
              child:  Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: startTime != null && endTime != null
                  ? () {
                context.read<ServicesBloc>().add(
                  AddTimeSlotEvent(
                    day: day,
                    slot: TimeSlot(
                      startTime: startTime!.format(context),
                      endTime: endTime!.format(context),
                    ),
                  ),
                );
                Navigator.pop(dialogContext);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child:  Text('add'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeBox({
    required TimeOfDay? time,
    required BuildContext ctx,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.blue.withOpacity(0.07)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppColors.blue
              : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time == null ? '--:-- --' : time.format(ctx),
            style: TextStyle(
              color: isSelected
                  ? AppColors.blue
                  : Colors.grey.shade500,
              fontWeight:
              isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Icon(
            Icons.access_time,
            color: isSelected
                ? AppColors.blue
                : Colors.grey.shade400,
          ),
        ],
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
                    fontSize: context.setSp(FontSize.s16),
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
                        Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: context.setWidth(4)),
                        Text(
                          "addDay".tr(),
                          style: getBoldStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Day cards
            ..._selectedDays.map(
                  (day) => DayScheduleCard(
                key: ValueKey(day),
                day: day,
                slots: state.availability[day] ?? [],
                onDelete: () => _removeDay(day),
                onAddSlot: () => _showTimeSlotPicker(day),
              ),
            ),
            // Empty state
            if (_selectedDays.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
                child: Center(
                  child: Text(
                    'noDaysAddedYet'.tr(),
                    style: getRegularStyle(
                      color: Colors.grey.shade400,
                      fontSize: context.setSp(FontSize.s12),
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