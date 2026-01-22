import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';

abstract class ElderOnboardingEvent {}

class GoToNextStepEvent extends ElderOnboardingEvent {}

class GoToPreviousStepEvent extends ElderOnboardingEvent {}

class SetGenderEvent extends ElderOnboardingEvent {
  final String gender;
  SetGenderEvent(this.gender);
}

class SetHasCaregiverEvent extends ElderOnboardingEvent{
  final bool value;
  SetHasCaregiverEvent(this.value);
}

class AddCaregiverIdEvent extends ElderOnboardingEvent{
  final String id;
  AddCaregiverIdEvent(this.id);
}

class RemoveCareGiverEvent extends ElderOnboardingEvent{
  final int indexToRemove;
  RemoveCareGiverEvent(this.indexToRemove);
}

class ContinueOnboardingEvent extends ElderOnboardingEvent{}

class GetAllergiesEvent extends ElderOnboardingEvent{}

class SetSelectedAllergiesEvent extends ElderOnboardingEvent {
  final List<AllergyEntity> allergies;
   SetSelectedAllergiesEvent(this.allergies);
}

class RemoveAllergyEvent extends ElderOnboardingEvent {
  final AllergyEntity allergy;
   RemoveAllergyEvent(this.allergy);
}

class GetDiseasesEvent extends ElderOnboardingEvent{}

class SetSelectedDiseasesEvent extends ElderOnboardingEvent {
  final List<DiseaseEntity> diseases;

  SetSelectedDiseasesEvent(this.diseases);
}

class RemoveDiseaseEvent extends ElderOnboardingEvent {
  final DiseaseEntity disease;
  RemoveDiseaseEvent(this.disease);
}

class GetBloodTypesEvent extends ElderOnboardingEvent{}

class SetSelectedBloodTypeEvent extends ElderOnboardingEvent {
  final BloodTypeEntity bloodType;
  SetSelectedBloodTypeEvent(this.bloodType);
}
class GetMobilityStatusEvent extends ElderOnboardingEvent{}

class SelectMobilityStatusEvent extends ElderOnboardingEvent {
  final int index;

  SelectMobilityStatusEvent(this.index);
}

class SubmitElderOnboardingDataEvent extends ElderOnboardingEvent {
  final ElderOnboardingRequest request;
  SubmitElderOnboardingDataEvent({required this.request});
}

