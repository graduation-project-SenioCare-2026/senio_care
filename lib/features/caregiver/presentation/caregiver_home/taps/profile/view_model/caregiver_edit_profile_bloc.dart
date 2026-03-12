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
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/domain/use_case/edit_profile/caregiver_profile_use_case.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';

@injectable
class CaregiverEditProfileBloc
    extends Bloc<CaregiverProfileEvent, CaregiverEditProfileState> {
  final CaregiverProfileUseCase _caregiverProfileUseCase;
  final GetCaregiverByIdUseCase _caregiverByIdUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final relationShipController = TextEditingController();
  final genderController = TextEditingController();
  final elderIdController = TextEditingController();
  List<String> initialElderIds = [];

  CaregiverEditProfileBloc(
      this._caregiverByIdUseCase,
      this._caregiverProfileUseCase,
      ) : super(const CaregiverEditProfileState()) {
    on<CaregiverInitProfileDataEvent>(_caregiverInitProfile);
    on<CaregiverEditProfileEvent>(_caregiverEditProfile);
    on<GetCaregiverByIdEvent>(_getCaregiverById);
    on<AddElderId>(_addElderId);
    on<RemoveElderId>(_removeElderId);
  }

  void _caregiverInitProfile(
      CaregiverInitProfileDataEvent event,
      Emitter<CaregiverEditProfileState> emit,
      ) {
    final caregiver = ProfileManager().caregiver;

    phoneNumberController.text = caregiver?.phoneNumber ?? '';
    relationShipController.text = caregiver?.relationship ?? '';
    genderController.text = caregiver?.gender ?? '';

    final elders = caregiver?.elders ?? [];

    initialElderIds =
        elders.map((e) => e.id).whereType<String>().toList();

    emit(
      state.copyWith(
        getElderState: elders.isNotEmpty
            ? StateStatus.success(elders)
            : const StateStatus.initial(),
      ),
    );
  }

  Future<void> _getCaregiverById(
      GetCaregiverByIdEvent event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    emit(state.copyWith(getCaregiverProfileState: const StateStatus.loading()));

    final result = await _caregiverByIdUseCase(event.id);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      final currentUser = UserManager().user!;
      UserManager().setUser(
        currentUser.copyWith(id: result.data.id, role: UserRole.caregiver),
      );

      // ✅ API already returns elders embedded — no extra fetch needed
      final elders = result.data.elders ?? [];

      emit(
        state.copyWith(
          getCaregiverProfileState: StateStatus.success(result.data),
          getElderState: elders.isNotEmpty
              ? StateStatus.success(elders)
              : const StateStatus.initial(),
        ),
      );
    } else if (result is Failure<CaregiverEntity>) {
      emit(
        state.copyWith(
          getCaregiverProfileState:
          StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _caregiverEditProfile(
      CaregiverEditProfileEvent event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    emit(
        state.copyWith(caregiverEditProfileState: const StateStatus.loading()));

    final result = await _caregiverProfileUseCase.call(event.id, event.request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      emit(
        state.copyWith(
          caregiverEditProfileState: StateStatus.success(result.data),
        ),
      );
    } else if (result is Failure<CaregiverEntity>) {
      emit(
        state.copyWith(
          caregiverEditProfileState:
          StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _addElderId(
      AddElderId event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    final caregiver = ProfileManager().caregiver;

    if (caregiver == null) {
      emit(
        state.copyWith(
          getElderState: StateStatus.failure(
            ResponseException(message: "Caregiver not found"),
          ),
        ),
      );
      return;
    }

    // ✅ Read current elders from state
    final currentElders = state.getElderState.data ?? <ElderEntity>[];

    // Prevent duplicates
    if (currentElders.any((e) => e.id == event.elderId)) return;

    emit(state.copyWith(getElderState: const StateStatus.loading()));

    final updatedElderIds = [
      ...currentElders.map((e) => e.id).whereType<String>(),
      event.elderId,
    ];

    final request = CaregiverOnboardingRequest(
      elderIds: updatedElderIds,
      phoneNumber: caregiver.phoneNumber,
      relationship: caregiver.relationship,
      gender: caregiver.gender,
    );

    final result = await _caregiverProfileUseCase.call(caregiver.id!, request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;
      final updatedElders = result.data.elders ?? <ElderEntity>[];
      emit(state.copyWith(getElderState: StateStatus.success(updatedElders)));
    } else if (result is Failure<CaregiverEntity>) {
      emit(
        state.copyWith(
          getElderState: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _removeElderId(
      RemoveElderId event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    final caregiver = ProfileManager().caregiver;
    if (caregiver == null) return;

    // ✅ Read current elders from state
    final currentElders = state.getElderState.data ?? <ElderEntity>[];

    final updatedElderIds = currentElders
        .map((e) => e.id)
        .whereType<String>()
        .where((id) => id != event.elderId)
        .toList();

    emit(state.copyWith(getElderState: const StateStatus.loading()));

    final request = CaregiverOnboardingRequest(
      elderIds: updatedElderIds,
      phoneNumber: caregiver.phoneNumber,
      relationship: caregiver.relationship,
      gender: caregiver.gender,
    );

    final result = await _caregiverProfileUseCase.call(caregiver.id!, request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      // ✅ API returns updated elders embedded in response
      final updatedElders = result.data.elders ?? <ElderEntity>[];

      emit(
        state.copyWith(
          getElderState: StateStatus.success(updatedElders),
        ),
      );
    } else if (result is Failure<CaregiverEntity>) {
      emit(
        state.copyWith(
          getElderState: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    phoneNumberController.dispose();
    relationShipController.dispose();
    genderController.dispose();
    elderIdController.dispose();
    return super.close();
  }
}