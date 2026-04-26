import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senio_care/core/enums/medicine_types.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/core/utils/date_parser.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';

class MedicationCard extends StatelessWidget {
  final bool isTaken;
  final VoidCallback onTap;
  final SlidableActionCallback onDelete;

  final DailyReminderEntity reminder;

  const MedicationCard({
    super.key,
    required this.isTaken,
    required this.onTap,
    required this.reminder,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final type = MedicineTypeX.fromString(reminder.medicineType);

    final bool isMissed =
        !isTaken && parseReminderDate(reminder.date).isBefore(DateTime.now());

    final Color color = isTaken
        ? Colors.green
        : isMissed
        ? Colors.red
        : Colors.blue;

    final Color lightColor = isTaken
        ? Colors.green.shade50
        : isMissed
        ? Colors.red.shade50
        : Colors.blue.shade50;

    final Color circleColor = isTaken
        ? Colors.green.shade100
        : isMissed
        ? Colors.red.shade100
        : Colors.blue.shade100;

    final IconData statusIcon = isTaken
        ? Icons.check_circle
        : isMissed
        ? Icons.cancel
        : Icons.radio_button_unchecked;

    final Color statusIconColor = isTaken
        ? Colors.green
        : isMissed
        ? Colors.red
        : Colors.grey;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHeight(3),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(16)),
          border: Border.all(color: color, width: context.setWidth(1.5)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.setMinSize(16)),
          child: Slidable(
            key: ValueKey(reminder.id ?? reminder.medicineName),
            startActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  onPressed: onDelete,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'delete'.tr(),
                ),
              ],
            ),
            child: InkWell(
              onTap: UserManager().role != UserRole.elder ? null : onTap,
              child: Container(
                padding: EdgeInsets.all(context.setWidth(16)),
                decoration: BoxDecoration(color: lightColor),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.setWidth(10)),
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(
                        type.icon,
                        color: color,
                        size: context.setWidth(20),
                      ),
                    ),

                    SizedBox(width: context.setWidth(12)),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reminder.medicineName ?? "",
                            style: getBoldStyle(
                              color: Colors.black,
                              fontSize: context.setSp(16),
                            ),
                          ),
                          if (reminder.notes != null &&
                              reminder.notes!.isNotEmpty)
                            Text(
                              reminder.notes!,
                              style: getRegularStyle(
                                color: Colors.black.withAlpha(160),
                                fontSize: context.setSp(14),
                              ),
                            ),
                          SizedBox(height: context.setHeight(4)),
                          Row(
                            children: [
                              if (reminder.dosage != null)
                                Text(
                                  "${reminder.dosage} ${type.getUnit()}",
                                  style: getRegularStyle(
                                    color: Colors.black.withAlpha(160),
                                    fontSize: context.setSp(14),
                                  ),
                                ),
                              SizedBox(width: context.setWidth(15)),
                              Text(
                                extractTime(reminder.date),
                                style: getRegularStyle(
                                  color: Colors.black.withAlpha(160),
                                  fontSize: context.setSp(14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      statusIcon,
                      color: statusIconColor,
                      size: context.setWidth(26),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String extractTime(String? date) {
  if (date == null) return '';
  if (date.length >= 16) {
    return date.substring(11);
  }
  return date;
}
