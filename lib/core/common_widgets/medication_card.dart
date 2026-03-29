import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senio_care/core/enums/medicine_types.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';

class MedicationCard extends StatelessWidget {

  final bool isTaken;
  final VoidCallback onTap;
  final DailyReminderEntity reminder;

  const MedicationCard({
    super.key,

    required this.isTaken,
    required this.onTap,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    final type = MedicineTypeX.fromString(reminder.medicineType);
    final color = isTaken ? Colors.green : Colors.blue;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHeight(3),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(context.setMinSize(16)),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.setWidth(16)),
          decoration: BoxDecoration(
            color: isTaken ? Colors.green.shade50 : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(context.setMinSize(16)),
            border: Border.all(
              color: color,
              width: context.setWidth(1.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.setWidth(10)),
                decoration: BoxDecoration(
                  color: isTaken
                      ? Colors.green.shade100
                      : Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  type.icon,
                  color: color,
                  size: context.setWidth(20),
                ),
              ),

              SizedBox(width: context.setWidth(12)),

              /// 📝 TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// اسم الدواء
                    Text(
                      reminder.medicineName ?? "",
                      style: getBoldStyle(
                        color: Colors.black,
                        fontSize: context.setSp(16),
                      ),
                    ),

                    SizedBox(height: context.setHeight(4)),

                    Row(
                      children: [
                        /// 💊 الجرعة + الوحدة
                        if (reminder.dosage != null)
                          Text(
                            "${reminder.dosage} ${type.getUnit()}",
                            style: getRegularStyle(
                              color: Colors.black.withAlpha(160),
                              fontSize: context.setSp(14),
                            ),
                          ),

                        SizedBox(width: context.setWidth(15)),

                        /// ⏰ الوقت
                        Text(
                          reminder.date?.substring(11, 16) ?? "",
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

              /// ✅ CHECK
              Icon(
                isTaken
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: isTaken ? Colors.green : Colors.grey,
                size: context.setWidth(26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}