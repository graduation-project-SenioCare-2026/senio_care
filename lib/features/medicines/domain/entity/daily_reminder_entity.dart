import 'package:equatable/equatable.dart';

class DailyReminderEntity extends Equatable {
  final String? id;
  final String? elderId;
  final String? medicineName;
  final String? dosage;
  final String? medicineType;
  final String? date;
  final String? notes;
  final String? state;

  const DailyReminderEntity({
    this.id,
    this.elderId,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.date,
    this.notes,
    this.state,
  });

  @override
  List<Object?> get props => [
    id,
    elderId,
    medicineName,
    medicineType,
    dosage,
    date,
    notes,
    state,
  ];
}
