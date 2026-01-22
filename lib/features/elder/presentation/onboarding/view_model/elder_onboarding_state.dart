import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/allergy_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/blood_type_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/disease_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/elder_onboarding_entity.dart';
import 'package:senio_care/features/elder/domain/entity/onboarding/mobility_status_entity.dart';

class ElderOnboardingState extends Equatable {
  final StateStatus<ElderOnboardingEntity> elderOnboardingStatus;
  final StateStatus<List<AllergyEntity>> allergiesStatus;
  final List<AllergyEntity> selectedAllergies;
  final StateStatus<List<DiseaseEntity>> diseasesStatus;
  final List<DiseaseEntity> selectedDiseases;
  final StateStatus<List<BloodTypeEntity>> bloodTypeStatus;
  final BloodTypeEntity? selectedBloodType;
  final StateStatus<List<MobilityStatusEntity>> mobilityStatusState;
  final MobilityStatusEntity? selectedMobilityState;
  final int? selectedMobilityIndex;
  final int currentIndex;
  final String? selectedGender;
  final bool hasCaregiver;
  final List<String> caregiverIds;
  final bool onboardingValidState;
  final String? destination;

  const ElderOnboardingState({
    this.elderOnboardingStatus = const StateStatus.initial(),
    this.allergiesStatus = const StateStatus.initial(),
    this.selectedAllergies = const [],
    this.diseasesStatus = const StateStatus.initial(),
    this.selectedDiseases = const [],
    this.bloodTypeStatus = const StateStatus.initial(),
    this.selectedBloodType,
    this.mobilityStatusState = const StateStatus.initial(),
    this.selectedMobilityState,
    this.selectedMobilityIndex,
    this.currentIndex = 0,
    this.selectedGender,
    this.hasCaregiver = false,
    this.caregiverIds = const [],
    this.onboardingValidState = false,
    this.destination,
  });

  ElderOnboardingState copyWith({
    StateStatus<ElderOnboardingEntity>? elderOnboardingStatus,
    StateStatus<List<AllergyEntity>>? allergiesStatus,
    List<AllergyEntity>? selectedAllergies,
    StateStatus<List<DiseaseEntity>>? diseasesStatus,
    List<DiseaseEntity>? selectedDiseases,
    StateStatus<List<BloodTypeEntity>>? bloodTypeStatus,
    BloodTypeEntity? selectedBloodType,
    StateStatus<List<MobilityStatusEntity>>? mobilityStatusState,
    MobilityStatusEntity? selectedMobilityState,
    int? selectedMobilityIndex,
    int? currentIndex,
    String? selectedGender,
    bool? hasCaregiver,
    List<String>? caregiverIds,
    bool? onboardingValidState,
    String? destination,
  }) {
    return ElderOnboardingState(
      elderOnboardingStatus:
          elderOnboardingStatus ?? this.elderOnboardingStatus,
      allergiesStatus: allergiesStatus ?? this.allergiesStatus,
      selectedAllergies: selectedAllergies ?? this.selectedAllergies,
      diseasesStatus: diseasesStatus ?? this.diseasesStatus,
      selectedDiseases: selectedDiseases ?? this.selectedDiseases,
      bloodTypeStatus: bloodTypeStatus ?? this.bloodTypeStatus,
      selectedBloodType: selectedBloodType ?? this.selectedBloodType,
      mobilityStatusState: mobilityStatusState ?? this.mobilityStatusState,
      selectedMobilityState:
          selectedMobilityState ?? this.selectedMobilityState,
      selectedMobilityIndex: selectedMobilityIndex ?? this.selectedMobilityIndex,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedGender: selectedGender ?? this.selectedGender,
      hasCaregiver: hasCaregiver ?? this.hasCaregiver,
      caregiverIds: caregiverIds ?? this.caregiverIds,
      onboardingValidState: onboardingValidState ?? this.onboardingValidState,
      destination: destination ?? this.destination,
    );
  }

  @override
  List<Object?> get props => [
    elderOnboardingStatus,
    allergiesStatus,
    selectedAllergies,
    diseasesStatus,
    selectedDiseases,
    bloodTypeStatus,
    selectedBloodType,
    mobilityStatusState,
    selectedMobilityState,
    selectedMobilityIndex,
    currentIndex,
    selectedGender,
    hasCaregiver,
    caregiverIds,
    onboardingValidState,
    destination,
  ];
}
