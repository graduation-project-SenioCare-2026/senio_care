import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/use_case/get_service_provider_by_id_use_case.dart';
import 'package:senio_care/features/service_provider/domain/use_case/edit_profile/service_provider_edit_profile_use_case.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_event.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/view_model/service_provider_edit_profile_state.dart';

import '../../../../../../../core/result/result.dart';
import '../../../../../../auth/domain/entity/service_provider_entity.dart';
import '../../../../../../elder/domain/entity/user_profile_entity.dart';
import '../../../../../../elder/domain/use_case/get_user_profile.dart';

@injectable
class ServiceProviderEditProfileBloc
    extends
        Bloc<ServiceProviderEditProfileEvent, ServiceProviderEditProfileState> {
  final ServiceProviderEditProfileUseCase _case;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final specializationController = TextEditingController();
  final genderController = TextEditingController();

  final GetServiceProviderByIdUseCase _providerByIdUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  ServiceProviderEditProfileBloc(
    this._case,
    this._providerByIdUseCase,
    this._getUserProfileUseCase,
  ) : super(ServiceProviderEditProfileState()) {
    on<ServiceProviderEditEvent>(_serviceProviderEditProfile);
    on<ServiceProviderInitProfile>(_initProfile);
    on<GetServiceProviderByIdEvent>(_getServiceProviderById);
    on<GetUserProfileEvent>(_getUserProfile);
  }

  void _getServiceProviderById(
    GetServiceProviderByIdEvent event,
    Emitter<ServiceProviderEditProfileState> emit,
  ) async {
    emit(state.copyWith(getServiceProviderStatus: StateStatus.loading()));

    final result = await _providerByIdUseCase(event.id);

    if (result is Success<ServiceProviderEntity>) {
      ProfileManager().serviceProvider = result.data;
      final currentUser = UserManager().user!;
      UserManager().setUser(
        currentUser.copyWith(
          id: result.data.id,
          role: UserRole.serviceProvider,
        ),
      );
      emit(
        state.copyWith(
          getServiceProviderStatus: StateStatus.success(result.data),
        ),
      );

      final userId = result.data.userId;

      if (userId != null) {
        add(GetUserProfileEvent(userId));
      }
    } else if (result is Failure<ServiceProviderEntity>) {
      emit(
        state.copyWith(
          getServiceProviderStatus: StateStatus.failure(
            result.responseException,
          ),
        ),
      );
    }
  }

  void _initProfile(
    ServiceProviderInitProfile event,
    Emitter<ServiceProviderEditProfileState> emit,
  ) {
    final service = ProfileManager().serviceProvider;
    phoneNumberController.text = service?.phoneNumber.toString() ?? "";
    specializationController.text = service?.specialization.toString() ?? "";
    genderController.text = service?.gender.toString() ?? "";
  }

  Future<void> _serviceProviderEditProfile(
    ServiceProviderEditEvent event,
    Emitter<ServiceProviderEditProfileState> emit,
  ) async {
    emit(
      state.copyWith(serviceProviderEditProfileState: StateStatus.loading()),
    );
    final result = await _case.call(event.id, event.request);

    switch (result) {
      case Success<ServiceProviderEntity>():
        emit(
          state.copyWith(
            serviceProviderEditProfileState: StateStatus.success(result.data),
            entity: result.data,
          ),
        );

      case Failure<ServiceProviderEntity>():
        emit(
          state.copyWith(
            serviceProviderEditProfileState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }

  Future<void> _getUserProfile(
    GetUserProfileEvent event,
    Emitter<ServiceProviderEditProfileState> emit,
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
}
