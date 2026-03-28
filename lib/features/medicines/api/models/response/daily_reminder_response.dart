import 'package:json_annotation/json_annotation.dart';
import 'package:senio_care/features/medicines/domain/entity/daily_reminder_entity.dart';

part 'daily_reminder_response.g.dart';

@JsonSerializable()
class DailyReminderResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "elder_id")
  final String? elderId;
  @JsonKey(name: "medicine_name")
  final String? medicineName;
  @JsonKey(name: "dosage")
  final String? dosage;
  @JsonKey(name: "medicine_type")
  final String? medicineType;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "state")
  final String? state;

  DailyReminderResponse ({
    this.id,
    this.elderId,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.date,
    this.notes,
    this.state,
  });

  factory DailyReminderResponse.fromJson(Map<String, dynamic> json) {
    return _$DailyReminderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyReminderResponseToJson(this);
  }

  DailyReminderEntity toEntity(){
    return DailyReminderEntity(
      id: id,
      elderId: elderId,
      medicineName: medicineName,
      dosage: dosage,
      medicineType: medicineType,
      date: date,
      notes: notes,
      state: state,
    );
  }
}


