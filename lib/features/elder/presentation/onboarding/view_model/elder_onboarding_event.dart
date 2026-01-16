import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';

abstract class ElderOnboardingEvent {}

class SubmitElderOnboardingDataEvent extends ElderOnboardingEvent {
  final ElderOnboardingRequest request;
  SubmitElderOnboardingDataEvent(this.request);
}

class CompleteLaterEvent extends ElderOnboardingEvent {}

class SetHasCaregiverEvent extends ElderOnboardingEvent{
  final bool value;
  SetHasCaregiverEvent(this.value);
}

class SetGenderEvent extends ElderOnboardingEvent{
  final bool value;
  SetGenderEvent(this.value);
}

class AddCaregiverIdEvent extends ElderOnboardingEvent{
  final String id;
  AddCaregiverIdEvent(this.id);
}

class RemoveCareGiverEvent extends ElderOnboardingEvent{
  final int indexToRemove;

  RemoveCareGiverEvent(this.indexToRemove);
}