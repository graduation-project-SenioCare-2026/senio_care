import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/submit_elder_onboarding_data.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

@injectable
class ElderOnboardingBloc
    extends Bloc<ElderOnboardingEvent, ElderOnboardingState> {
  final SubmitElderOnboardingDataUseCse _submitElderOnboardingDataUseCse;

  ElderOnboardingBloc(this._submitElderOnboardingDataUseCse)
      : super(ElderOnboardingState()) {
    on<SubmitElderOnboardingDataEvent>(_submitElderOnboardingData);
    on<SetHasCaregiverEvent>(_setHasCaregiver);
    on<AddCaregiverIdEvent>(_addCaregiverId);
    on<RemoveCareGiverEvent>(_removeCaregiver);
  }
  final ageController = TextEditingController();
  final caregiverIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _submitElderOnboardingData(
      SubmitElderOnboardingDataEvent event,
      Emitter<ElderOnboardingState> emit,
      ) async {
    emit(state.copyWith(elderOnboardingStatus: StateStatus.loading()));

    final result = await _submitElderOnboardingDataUseCse(event.request);

    switch (result) {
      case Success<ElderOnboardingEntity>():
        emit(
          state.copyWith(
            elderOnboardingStatus: StateStatus.success(result.data),
          ),
        );
      case Failure<ElderOnboardingEntity>():
        emit(
          state.copyWith(
            elderOnboardingStatus:
            StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _setHasCaregiver(
      SetHasCaregiverEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    if (!event.value) {
      emit(state.copyWith(
        hasCaregiver: false,
        caregiverIds: [],
      ));
    } else {
      emit(state.copyWith(hasCaregiver: true));
    }
  }

  void _addCaregiverId(
      AddCaregiverIdEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    if (event.id.isEmpty) return;
    if (state.caregiverIds.contains(event.id)) return;

    emit(
      state.copyWith(
        caregiverIds: [...state.caregiverIds, event.id],
      ),
    );
  }

  void _removeCaregiver(
      RemoveCareGiverEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {

    final updatedList = List<String>.from(state.caregiverIds)
      ..removeAt(event.indexToRemove);

    emit(state.copyWith(caregiverIds: updatedList));
  }
}
