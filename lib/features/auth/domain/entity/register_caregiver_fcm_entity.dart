import 'package:equatable/equatable.dart';

class RegisterCaregiverFcmEntity extends Equatable {
  final String? elderUserId;
  final String? caregiverId;
  final String? name;
  final String? relationship;
  final String? fcmToken;

 const  RegisterCaregiverFcmEntity({
    this.elderUserId,
    this.caregiverId,
    this.name,
    this.relationship,
    this.fcmToken,
  });

  @override
  List<Object?> get props => [
    elderUserId,
    caregiverId,
    name,
    relationship,
    fcmToken,
  ];
}
