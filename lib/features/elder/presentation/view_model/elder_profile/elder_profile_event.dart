import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

class ElderProfileEvent {}

class InitElderProfileEvent extends ElderProfileEvent {}

class SetDiseasesEvent extends ElderProfileEvent {
  final List<DiseaseEntity> diseases;
  SetDiseasesEvent(this.diseases);
}

class AddDiseaseEvent extends ElderProfileEvent {
  final DiseaseEntity disease;
  AddDiseaseEvent(this.disease);
}

class RemoveDiseaseEditEvent extends ElderProfileEvent {
  final DiseaseEntity disease;
  RemoveDiseaseEditEvent(this.disease);
}

class SetAllergiesEvent extends ElderProfileEvent {
  final List<AllergyEntity> allergies;
  SetAllergiesEvent(this.allergies);
}

class AddAllergyEvent extends ElderProfileEvent {
  final AllergyEntity allergy;
  AddAllergyEvent(this.allergy);
}

class RemoveAllergyEditEvent extends ElderProfileEvent {
  final AllergyEntity allergy;
  RemoveAllergyEditEvent(this.allergy);
}

class SetBloodTypeEvent extends ElderProfileEvent {
  final BloodTypeEntity bloodType;
  SetBloodTypeEvent(this.bloodType);
}

class SetMobilityEvent extends ElderProfileEvent {
  final MobilityStatusEntity mobilityStatus;
  SetMobilityEvent(this.mobilityStatus);
}

class GetElderEvent extends ElderProfileEvent {
  final String id;
  GetElderEvent(this.id);
}

class AddCaregiverEvent extends ElderProfileEvent {
  final String id;
  AddCaregiverEvent(this.id);
}

class RemoveCaregiverEvent extends ElderProfileEvent {
  final String id;
  RemoveCaregiverEvent(this.id);
}

class EditElderProfileEvent extends ElderProfileEvent {
  final String id;
  final ElderOnboardingRequest request;
  EditElderProfileEvent(this.id, this.request);
}
