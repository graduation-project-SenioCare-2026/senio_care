import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';
import 'package:senio_care/features/elder/domain/entity/user_profile_entity.dart';

class ElderProfileState extends Equatable {
  final StateStatus<ElderEntity> editElderProfileStatus;
  final List<DiseaseEntity> selectedDiseases;
  final List<AllergyEntity> selectedAllergies;
  final BloodTypeEntity? selectedBloodType;
  final MobilityStatusEntity? selectedMobilityStatus;
  final StateStatus<ElderEntity>? getElderStatus;
  final List<CaregiverEntity> caregivers;
  final StateStatus<UserProfileEntity> getUserStatus;

  const ElderProfileState({
    this.editElderProfileStatus = const StateStatus.initial(),
    this.selectedDiseases = const [],
    this.selectedAllergies = const [],
    this.selectedBloodType,
    this.selectedMobilityStatus,
    this.getElderStatus = const StateStatus.initial(),
    this.caregivers = const [],
    this.getUserStatus= const StateStatus.initial(),
  });

  ElderProfileState copyWith({
    StateStatus<ElderEntity>? editElderProfileStatus,
    List<DiseaseEntity>? selectedDiseases,
    List<AllergyEntity>? selectedAllergies,
    BloodTypeEntity? selectedBloodType,
    MobilityStatusEntity? selectedMobilityStatus,
    StateStatus<ElderEntity>? getElderStatus,
    List<CaregiverEntity>? caregivers,
    StateStatus<UserProfileEntity>? getUserStatus
  }) {
    return ElderProfileState(
      editElderProfileStatus: editElderProfileStatus ?? this.editElderProfileStatus,
      selectedDiseases: selectedDiseases ?? this.selectedDiseases,
      selectedAllergies: selectedAllergies ?? this.selectedAllergies,
      selectedBloodType: selectedBloodType ?? this.selectedBloodType,
      selectedMobilityStatus: selectedMobilityStatus ?? this.selectedMobilityStatus,
      getElderStatus: getElderStatus ?? this.getElderStatus,
      caregivers: caregivers ?? this.caregivers,
      getUserStatus: getUserStatus??this.getUserStatus
    );
  }

  @override
  List<Object?> get props => [
    editElderProfileStatus,
    selectedDiseases,
    selectedAllergies,
    selectedBloodType,
    selectedMobilityStatus,
    getElderStatus,
    caregivers,
    getUserStatus
  ];
}
