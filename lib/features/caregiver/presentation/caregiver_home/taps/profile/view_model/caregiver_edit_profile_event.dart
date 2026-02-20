import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';

abstract class CaregiverProfileEvent {}

class CaregiverInitProfileDataEvent extends CaregiverProfileEvent {}

class AddElderId extends CaregiverProfileEvent {
  final String elderId;
  AddElderId(this.elderId);
}

class RemoveElderId extends CaregiverProfileEvent {
  final String elderId;
  RemoveElderId(this.elderId);
}

class CaregiverEditProfileEvent extends CaregiverProfileEvent {
  final String id;
  final CaregiverOnboardingRequest request;
  CaregiverEditProfileEvent(this.id, this.request);
}

class GetCaregiverByIdEvent extends CaregiverProfileEvent {
  final String id;
  GetCaregiverByIdEvent(this.id);
}

class GetMultipleEldersEvent extends CaregiverProfileEvent {
  final List<String> elderIds;
  GetMultipleEldersEvent(this.elderIds);
}