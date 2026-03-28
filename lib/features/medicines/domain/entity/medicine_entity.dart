import 'package:equatable/equatable.dart';

class MedicineEntity extends Equatable {
  final String? id;
  final String? elderId;
  final String? medicineName;
  final String? dosage;
  final String? medicineType;
  final List<String>? times;
  final String? startDate;
  final String? endDate;
  final String? notes;
  final String? state;

  const MedicineEntity({
    this.id,
    this.elderId,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.times,
    this.startDate,
    this.endDate,
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
    times,
    startDate,
    endDate,
    notes,
  ];
}
