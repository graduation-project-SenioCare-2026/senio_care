import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/exceptions/response_exception.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/edit_elder_profile_use_case.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

@injectable
class ElderProfileBloc extends Bloc<ElderProfileEvent, ElderProfileState> {
  final EditElderProfileUseCase _editElderProfileUseCase;
  final GetElderByIdUseCase _getElderByIdUseCase;
  final GetCaregiverByIdUseCase _getCaregiverByIdUseCase;

  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final caregiverIdController = TextEditingController();

  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();

  ElderProfileBloc(
    this._editElderProfileUseCase,
    this._getElderByIdUseCase,
    this._getCaregiverByIdUseCase,
  ) : super(const ElderProfileState()) {
    on<InitElderProfileEvent>(_onInitProfile);
    on<SetDiseasesEvent>(_onSetDiseases);
    on<AddDiseaseEvent>(_onAddDisease);
    on<RemoveDiseaseEditEvent>(_onRemoveDisease);
    on<SetAllergiesEvent>(_onSetAllergies);
    on<AddAllergyEvent>(_onAddAllergy);
    on<RemoveAllergyEditEvent>(_onRemoveAllergy);
    on<SetBloodTypeEvent>(_setBloodTypeEvent);
    on<SetMobilityEvent>(_setMobilityEvent);
    on<GetElderEvent>(_getElderById);
    on<EditElderProfileEvent>(_editElderProfile);
    on<GetMultipleCaregiversEvent>(_getMultipleCaregivers);
  }

  void _onInitProfile(
    InitElderProfileEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    final elder = ProfileManager().elder;

    ageController.text = elder?.age?.toString() ?? '';
    weightController.text = elder?.weight?.toString() ?? '';
    heightController.text = elder?.height?.toString() ?? '';

    emit(
      state.copyWith(
        selectedDiseases: (elder?.chronicDiseases ?? [])
            .map((e) => DiseaseEntity(en: e, ar: e))
            .toList(),
        selectedAllergies: (elder?.allergies ?? [])
            .map((e) => AllergyEntity(en: e, ar: e))
            .toList(),
      ),
    );
  }

  void _onSetDiseases(SetDiseasesEvent event, Emitter<ElderProfileState> emit) {
    emit(state.copyWith(selectedDiseases: List.from(event.diseases)));
  }

  void _onAddDisease(AddDiseaseEvent event, Emitter<ElderProfileState> emit) {
    if (!state.selectedDiseases.any((d) => d.en == event.disease.en)) {
      emit(
        state.copyWith(
          selectedDiseases: [...state.selectedDiseases, event.disease],
        ),
      );
    }
  }

  void _onRemoveDisease(
    RemoveDiseaseEditEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(
      state.copyWith(
        selectedDiseases: state.selectedDiseases
            .where((e) => e != event.disease)
            .toList(),
      ),
    );
  }

  void _onSetAllergies(
    SetAllergiesEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(state.copyWith(selectedAllergies: List.from(event.allergies)));
  }

  void _onAddAllergy(AddAllergyEvent event, Emitter<ElderProfileState> emit) {
    if (!state.selectedAllergies.any((a) => a.en == event.allergy.en)) {
      emit(
        state.copyWith(
          selectedAllergies: [...state.selectedAllergies, event.allergy],
        ),
      );
    }
  }

  void _onRemoveAllergy(
    RemoveAllergyEditEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(
      state.copyWith(
        selectedAllergies: state.selectedAllergies
            .where((e) => e != event.allergy)
            .toList(),
      ),
    );
  }

  void _setBloodTypeEvent(
    SetBloodTypeEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(state.copyWith(selectedBloodType: event.bloodType));
  }

  void _setMobilityEvent(
    SetMobilityEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(state.copyWith(selectedMobilityStatus: event.mobilityStatus));
  }

  Future<void> _editElderProfile(
    EditElderProfileEvent event,
    Emitter<ElderProfileState> emit,
  ) async {
    emit(state.copyWith(editElderProfileStatus: const StateStatus.loading()));

    final result = await _editElderProfileUseCase.call(event.id, event.request);

    if (result is Success<ElderEntity>) {
      ProfileManager().elder = result.data;
      emit(
        state.copyWith(
          editElderProfileStatus: StateStatus.success(result.data),
        ),
      );
    } else if (result is Failure<ElderEntity>) {
      emit(
        state.copyWith(
          editElderProfileStatus: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _getElderById(
    GetElderEvent event,
    Emitter<ElderProfileState> emit,
  ) async {
    emit(state.copyWith(getElderStatus: const StateStatus.loading()));

    final result = await _getElderByIdUseCase(event.id);

    if (result is Success<ElderEntity>) {
      ProfileManager().elder = result.data;

      final currentUser = UserManager().user!;
      UserManager().setUser(
        currentUser.copyWith(id: result.data.id, role: UserRole.elder),
      );

      emit(state.copyWith(getElderStatus: StateStatus.success(result.data)));
    } else if (result is Failure<ElderEntity>) {
      emit(
        state.copyWith(
          getElderStatus: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _getMultipleCaregivers(
      GetMultipleCaregiversEvent event,
      Emitter<ElderProfileState> emit,
      ) async {
    emit(state.copyWith(
      getCaregiversStatus: const StateStatus.loading(),
    ));

    final List<CaregiverEntity> caregivers = [];
    final List<String> failedIds = [];

    for (final id in event.caregiverIds) {
      final result = await _getCaregiverByIdUseCase.call(id);

      switch (result) {
        case Success<CaregiverEntity>():
          caregivers.add(result.data);
          break;

        case Failure<CaregiverEntity>():
          failedIds.add(id);
          break;
      }
    }

    if (caregivers.isNotEmpty) {
      emit(state.copyWith(
        getCaregiversStatus: StateStatus.success(caregivers),
      ));
    } else {
      emit(state.copyWith(
        getCaregiversStatus: StateStatus.failure(
          ResponseException(message: 'Failed to load caregivers'),
        ),
      ));
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
