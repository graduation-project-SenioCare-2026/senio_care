import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/domain/use_case/edit_profile/caregiver_profile_use_case.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_event.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/profile/view_model/caregiver_edit_profile_state.dart';
import '../../../../../../../core/exceptions/response_exception.dart';

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

    emit(
      state.copyWith(
        // elderId: caregiver?.elderIds ?? [],
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

      // // ✅ Extract IDs from elders list if elderIds is null, filtering out nulls
      // final elderIdsToSet = result.data.elderIds ??
      //     result.data.elders?.map((e) => e.id).whereType<String>().toList() ??
      //     [];



      emit(
        state.copyWith(
          getCaregiverProfileState: StateStatus.success(result.data),
          // elderId: elderIdsToSet,
        ),
      );

    } else if (result is Failure<CaregiverEntity>) {


      emit(
        state.copyWith(
          getCaregiverProfileState: StateStatus.failure(result.responseException),
        ),
      );
    }
  }

  Future<void> _caregiverEditProfile(
      CaregiverEditProfileEvent event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    emit(state.copyWith(caregiverEditProfileState: const StateStatus.loading()));

    final result = await _caregiverProfileUseCase.call(event.id, event.request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      // ✅ Extract IDs, filtering out nulls
      // final elderIdsToSet = result.data.elderIds ??
      //     result.data.elders?.map((e) => e.id).whereType<String>().toList() ??
      //     [];

      emit(
        state.copyWith(
          caregiverEditProfileState: StateStatus.success(result.data),
          // elderId: elderIdsToSet,
        ),
      );
    } else if (result is Failure<CaregiverEntity>) {
      emit(
        state.copyWith(
          caregiverEditProfileState: StateStatus.failure(result.responseException),
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
          getCaregiverProfileState: StateStatus.failure(
            ResponseException(message: "Caregiver not found"),
          ),
        ),
      );
      return;
    }

    // ✅ Get current IDs from elderIds OR extract from elders, filtering out nulls
    // final currentElderIds = caregiver.elderIds ??
    //     caregiver.elders?.map((e) => e.id).whereType<String>().toList() ??
    //     [];

    // if (currentElderIds.contains(event.elderId)) return;

    emit(state.copyWith(getElderState: const StateStatus.loading()));

    // final updatedElderIds = [...currentElderIds, event.elderId];

    final request = CaregiverOnboardingRequest(
      // elderIds: updatedElderIds,
      phoneNumber: caregiver.phoneNumber,
      relationship: caregiver.relationship,
      gender: caregiver.gender,
    );

    final result = await _caregiverProfileUseCase.call(caregiver.id!, request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      // ✅ Extract IDs, filtering out nulls
      // final elderIdsToSet = result.data.elderIds ??
      //     result.data.elders?.map((e) => e.id).whereType<String>().toList() ??
      //     [];

      emit(
        state.copyWith(
          // elderId: elderIdsToSet,
          getElderState: StateStatus.success(result.data),
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

  Future<void> _removeElderId(
      RemoveElderId event,
      Emitter<CaregiverEditProfileState> emit,
      ) async {
    final caregiver = ProfileManager().caregiver;
    if (caregiver == null) return;

    // ✅ Get current IDs, filtering out nulls
    // final currentElderIds = caregiver.elderIds ??
    //     caregiver.elders?.map((e) => e.id).whereType<String>().toList() ??
    //     [];

    // final updatedElderIds = currentElderIds.where((id) => id != event.elderId).toList();

    emit(state.copyWith(getElderState: const StateStatus.loading()));

    final request = CaregiverOnboardingRequest(
      // elderIds: updatedElderIds,
      phoneNumber: caregiver.phoneNumber,
      relationship: caregiver.relationship,
      gender: caregiver.gender,
    );

    final result = await _caregiverProfileUseCase.call(caregiver.id!, request);

    if (result is Success<CaregiverEntity>) {
      ProfileManager().caregiver = result.data;

      // ✅ Extract IDs, filtering out nulls
      // final elderIdsToSet = result.data.elderIds ??
      //     result.data.elders?.map((e) => e.id).whereType<String>().toList() ??
      //     [];

      emit(
        state.copyWith(
          // elderId: elderIdsToSet,
          getElderState: StateStatus.success(result.data),
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
}
