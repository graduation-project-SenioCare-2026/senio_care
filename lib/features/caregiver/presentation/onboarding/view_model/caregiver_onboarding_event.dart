import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';

abstract class CaregiverOnboardingEvent {}

class CaregiverSubmitDataEvent extends CaregiverOnboardingEvent {
  final CaregiverOnboardingRequest request;
  CaregiverSubmitDataEvent(this.request);
}

class CaregiverSetGenderEvent extends CaregiverOnboardingEvent{
  final String gender;
  CaregiverSetGenderEvent(this.gender);
}
