import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/caregiver/domain/use_case/onboarding/submit_caregiver_onboarding_data.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_event.dart';
import 'package:senio_care/features/caregiver/presentation/onboarding/view_model/caregiver_onboarding_state.dart';

@injectable
class CaregiverOnboardingBloc
    extends Bloc<CaregiverOnboardingEvent, CaregiverOnboardingState> {
  // useCase
  final SubmitCaregiverOnboardingData _caregiverOnboardingData;

  final  phoneNumberController = TextEditingController();
  final  relationController = TextEditingController();
  final  elderIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CaregiverOnboardingBloc(this._caregiverOnboardingData)
    : super(CaregiverOnboardingState()) {
    on<CaregiverSetGenderEvent>(_setGender);
    on<CaregiverSubmitDataEvent>(_caregiverOnboardingEvent);
  }

  void _setGender(
    CaregiverSetGenderEvent event,
    Emitter<CaregiverOnboardingState> emit,
  ) {
    emit(state.copyWith(selectedGender: event.gender));
  }

  Future<void> _caregiverOnboardingEvent(
    CaregiverSubmitDataEvent event,
    Emitter<CaregiverOnboardingState> emit,
  ) async {
    emit(state.copyWith(caregiverOnboardingState: StateStatus.loading()));
    final result = await _caregiverOnboardingData.call(event.request);
    switch (result) {
      case Success<CaregiverEntity>():
        emit(
          state.copyWith(
            caregiverOnboardingState: StateStatus.success(result.data),
          ),
        );
      case Failure<CaregiverEntity>():
        emit(
          state.copyWith(
            caregiverOnboardingState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }
}
