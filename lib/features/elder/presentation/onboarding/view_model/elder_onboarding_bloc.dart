import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/user_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/get_allergy_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/get_blood_types_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/get_diseases_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/get_mobility_status_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/onboarding/submit_elder_onboarding_data.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_event.dart';
import 'package:senio_care/features/elder/presentation/onboarding/view_model/elder_onboarding_state.dart';

@injectable
class ElderOnboardingBloc
    extends Bloc<ElderOnboardingEvent, ElderOnboardingState> {
  final SubmitElderOnboardingDataUseCse _submitElderOnboardingDataUseCse;
  final GetAllergyUseCase _getAllergyUseCase;
  final GetDiseasesUseCase _getDiseasesUseCase;
  final GetBloodTypesUseCase _getBloodTypesUseCase;
  final GetMobilityStatusUseCase _getMobilityStatusUseCase;

  ElderOnboardingBloc(
    this._submitElderOnboardingDataUseCse,
    this._getAllergyUseCase,
      this._getDiseasesUseCase,
      this._getBloodTypesUseCase,
      this._getMobilityStatusUseCase
  ) : super(ElderOnboardingState()) {

    on<SetGenderEvent>(_setGender);
    on<SetHasCaregiverEvent>(_setHasCaregiver);
    on<AddCaregiverIdEvent>(_addCaregiverId);
    on<RemoveCareGiverEvent>(_removeCaregiver);
    on<GetAllergiesEvent>(_getAllergies);
    on<SetSelectedAllergiesEvent>(_setSelectedAllergies);
    on<RemoveAllergyEvent>(_removeAllergy);
    on<GetDiseasesEvent>(_getDiseases);
    on<SetSelectedDiseasesEvent>(_setSelectedDiseases);
    on<RemoveDiseaseEvent>(_removeDisease);
    on<GetBloodTypesEvent>(_getBloodTypes);
    on<SetSelectedBloodTypeEvent>(_setSelectedBloodType);
    on<GetMobilityStatusEvent>(_getMobilityStatus);
    on<GoToNextStepEvent>(_goToNextStep);
    on<GoToPreviousStepEvent>(_goToPreviousStep);
    on<SubmitElderOnboardingDataEvent>(_submitElderOnboardingData);
    on<SelectMobilityStatusEvent>(_selectMobilityStatusEvent);

    add(GetAllergiesEvent());
    add(GetDiseasesEvent());
    add(GetBloodTypesEvent());
    add(GetMobilityStatusEvent());

  }
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final caregiverIdController = TextEditingController();
  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> healthInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mobilityFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> elderCaregiverFormKey = GlobalKey<FormState>();
  final totalSteps = 4;

  void _goToNextStep(
    GoToNextStepEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    if (state.currentIndex < totalSteps - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _goToPreviousStep(
    GoToPreviousStepEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _setGender(SetGenderEvent event, Emitter<ElderOnboardingState> emit) {
    emit(state.copyWith(selectedGender: event.gender));
  }

  void _setHasCaregiver(
    SetHasCaregiverEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    if (!event.value) {
      emit(state.copyWith(hasCaregiver: false, caregiverIds: []));
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

    emit(state.copyWith(caregiverIds: [...state.caregiverIds, event.id]));
  }

  void _removeCaregiver(
    RemoveCareGiverEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    final updatedList = List<String>.from(state.caregiverIds)
      ..removeAt(event.indexToRemove);

    emit(state.copyWith(caregiverIds: updatedList));
  }

  Future<void> _getAllergies(
    GetAllergiesEvent event,
    Emitter<ElderOnboardingState> emit,
  ) async {
    emit(state.copyWith(allergiesStatus: StateStatus.loading()));

    final result = await _getAllergyUseCase.call();

    switch (result) {
      case Success<List<AllergyEntity>>():

        emit(state.copyWith(allergiesStatus: StateStatus.success(result.data)));
      case Failure<List<AllergyEntity>>():

        emit(
          state.copyWith(
            allergiesStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _setSelectedAllergies(
    SetSelectedAllergiesEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    emit(state.copyWith(selectedAllergies: event.allergies));
  }

  void _removeAllergy(
    RemoveAllergyEvent event,
    Emitter<ElderOnboardingState> emit,
  ) {
    final updatedList = List<AllergyEntity>.from(state.selectedAllergies)
      ..remove(event.allergy);
    emit(state.copyWith(selectedAllergies: updatedList));
  }

  Future<void> _getDiseases(
      GetDiseasesEvent event,
      Emitter<ElderOnboardingState> emit,
      ) async {
    emit(state.copyWith(diseasesStatus: StateStatus.loading()));

    final result = await _getDiseasesUseCase.call();

    switch (result) {
      case Success<List<DiseaseEntity>>():

        emit(state.copyWith(diseasesStatus: StateStatus.success(result.data)));
      case Failure<List<DiseaseEntity>>():

        emit(
          state.copyWith(
            diseasesStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _setSelectedDiseases(
      SetSelectedDiseasesEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    emit(state.copyWith(selectedDiseases: event.diseases));
  }

  void _removeDisease(
      RemoveDiseaseEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    final updatedList = List<DiseaseEntity>.from(state.selectedDiseases)
      ..remove(event.disease);
    emit(state.copyWith(selectedDiseases: updatedList));
  }

  Future<void> _getBloodTypes(
      GetBloodTypesEvent event,
      Emitter<ElderOnboardingState> emit,
      ) async {
    emit(state.copyWith(bloodTypeStatus: StateStatus.loading()));

    final result = await _getBloodTypesUseCase.call();

    switch (result) {
      case Success<List<BloodTypeEntity>>():
        emit(state.copyWith(bloodTypeStatus: StateStatus.success(result.data)));

      case Failure<List<BloodTypeEntity>>():
        emit(
          state.copyWith(
            bloodTypeStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _setSelectedBloodType(
      SetSelectedBloodTypeEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    emit(state.copyWith(selectedBloodType: event.bloodType));
  }

  Future<void> _getMobilityStatus(
      GetMobilityStatusEvent event,
      Emitter<ElderOnboardingState> emit,
      ) async {
    emit(state.copyWith(mobilityStatusState: StateStatus.loading()));


    final result = await _getMobilityStatusUseCase.call();

    switch (result) {
      case Success<List<MobilityStatusEntity>>():
        emit(state.copyWith(mobilityStatusState: StateStatus.success(result.data)));
      case Failure<List<MobilityStatusEntity>>():
        emit(
          state.copyWith(
            mobilityStatusState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }


  void _selectMobilityStatusEvent(
      SelectMobilityStatusEvent event,
      Emitter<ElderOnboardingState> emit,
      ) {
    final list = state.mobilityStatusState.data ?? [];

    emit(state.copyWith(
        selectedMobilityIndex: event.index,
      selectedMobilityState: list[event.index],));
  }

  Future<void> _submitElderOnboardingData(
    SubmitElderOnboardingDataEvent event,
    Emitter<ElderOnboardingState> emit,
  ) async {
    emit(state.copyWith(elderOnboardingStatus: StateStatus.loading()));

    final result = await _submitElderOnboardingDataUseCse(event.request);

    switch (result) {
      case Success<ElderEntity>():
        emit(
          state.copyWith(
            elderOnboardingStatus: StateStatus.success(result.data),
            destination: RoutesNames.elderHome,
          ),
        );
        ProfileManager().elder = result.data;
        UserManager().setUser(
          UserEntity(id: result.data.id, role: UserRole.serviceProvider),
        );
      case Failure<ElderEntity>():
        emit(
          state.copyWith(
            elderOnboardingStatus: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    caregiverIdController.dispose();
    return super.close();
  }

}
