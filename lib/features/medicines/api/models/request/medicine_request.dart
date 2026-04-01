import 'package:json_annotation/json_annotation.dart';

part 'medicine_request.g.dart';

@JsonSerializable()
class MedicineRequest {
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

  MedicineRequest ({
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

  factory MedicineRequest.fromJson(Map<String, dynamic> json) {
    return _$MedicineRequestFromJson(json);
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (elderId != null) map['elder_id'] = elderId;
    if (medicineName != null) map['medicine_name'] = medicineName;
    if (dosage != null) map['dosage'] = dosage;
    if (medicineType != null) map['medicine_type'] = medicineType;
    if (times != null) map['times'] = times;
    if (startDate != null) map['start_date'] = startDate;
    if (endDate != null) map['end_date'] = endDate;
    if (notes != null) map['notes'] = notes;
    if (state != null) map['state'] = state;
    return map;
  }
}


