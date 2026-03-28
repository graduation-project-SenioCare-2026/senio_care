import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/medicines/domain/entity/medicine_entity.dart';

part 'medicine_response.g.dart';

@JsonSerializable()
class MedicineResponse {
  @JsonKey(name: "elder_id")
  final String? elderId;
  @JsonKey(name: "medicine_name")
  final String? medicineName;
  @JsonKey(name: "dosage")
  final String? dosage;
  @JsonKey(name: "medicine_type")
  final String? medicineType;
  @JsonKey(name: "times")
  final List<String>? times;
  @JsonKey(name: "start_date")
  final String? startDate;
  @JsonKey(name: "end_date")
  final String? endDate;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "_id")
  final String? id;

  MedicineResponse ({
    this.elderId,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.times,
    this.startDate,
    this.endDate,
    this.notes,
    this.state,
    this.id,
  });

  factory MedicineResponse.fromJson(Map<String, dynamic> json) {
    return _$MedicineResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MedicineResponseToJson(this);
  }
  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      elderId: elderId,
      medicineName: medicineName,
      dosage: dosage,
      medicineType: medicineType,
      times: times ?? [],
      startDate: startDate,
      endDate: endDate,
      notes: notes,
      state: state,
    );
  }
}


