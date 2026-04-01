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

  DailyReminderEntity copyWith({
    String? id,
    String? elderId,
    String? medicineName,
    String? dosage,
    String? medicineType,
    String? date,
    String? notes,
    String? state,
  }) {
    return DailyReminderEntity(
      id: id ?? this.id,
      elderId: elderId ?? this.elderId,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      medicineType: medicineType ?? this.medicineType,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      state: state ?? this.state,
    );
  }
}