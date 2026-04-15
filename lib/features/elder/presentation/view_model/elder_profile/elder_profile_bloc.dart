import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/user_profile_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/edit_elder_profile_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/get_user_profile.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

@injectable
class ElderProfileBloc extends Bloc<ElderProfileEvent, ElderProfileState> {
  final EditElderProfileUseCase _editElderProfileUseCase;
  final GetElderByIdUseCase _getElderByIdUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final caregiverIdController = TextEditingController();

  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();

  ElderProfileBloc(
    this._editElderProfileUseCase,
    this._getElderByIdUseCase,
    this._getUserProfileUseCase,
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
    on<AddCaregiverEvent>(_addCaregiver);
    on<RemoveCaregiverEvent>(_removeCaregiver);
    on<EditElderProfileEvent>(_editElderProfile);
    on<GetUserProfileEvent>(_getProfileEvent);
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
        caregivers: elder?.caregiverIds ?? [],
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

  void _addCaregiver(AddCaregiverEvent event, Emitter<ElderProfileState> emit) {
    final alreadyExists = state.caregivers.any((c) => c.id == event.id);
    if (!alreadyExists) {
      final newCaregiver = CaregiverEntity(id: event.id);
      emit(state.copyWith(caregivers: [...state.caregivers, newCaregiver]));
    }
  }

  void _removeCaregiver(
    RemoveCaregiverEvent event,
    Emitter<ElderProfileState> emit,
  ) {
    emit(
      state.copyWith(
        caregivers: state.caregivers.where((c) => c.id != event.id).toList(),
      ),
    );
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
        currentUser.copyWith(
          id: result.data.id,
          role: UserRole.elder,
        ),
      );

      emit(state.copyWith(getElderStatus: StateStatus.success(result.data)));

      final userId = result.data.userId;

      if (userId != null) {
        add(GetUserProfileEvent(userId));
      }
    } else if (result is Failure<ElderEntity>) {
      emit(
        state.copyWith(
          getElderStatus: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _getProfileEvent(
    GetUserProfileEvent event,
    Emitter<ElderProfileState> emit,
  ) async {
    emit(state.copyWith(getUserStatus: const StateStatus.loading()));
    final result = await _getUserProfileUseCase(event.id);

    switch (result) {
      case Success<UserProfileEntity>():
        emit(state.copyWith(getUserStatus: StateStatus.success(result.data)));


      case Failure<UserProfileEntity>():
        emit(
          state.copyWith(
            getUserStatus: StateStatus.failure(result.responseException),
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
