import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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

@injectable
class ServiceProviderEditProfileBloc
    extends
        Bloc<ServiceProviderEditProfileEvent, ServiceProviderEditProfileState> {
  final ServiceProviderEditProfileUseCase _case;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final specializationController = TextEditingController();
  final GetServiceProviderByIdUseCase _providerByIdUseCase;
  ServiceProviderEditProfileBloc(this._case, this._providerByIdUseCase)
    : super(ServiceProviderEditProfileState()) {
    on<ServiceProviderEditEvent>(_serviceProviderEditProfile);
    // on<ServiceProviderLoadData>(_serviceProviderLoadData);
    on<ServiceProviderInitProfile>(_initProfile);
    on<GetServiceProviderByIdEvent>(_getServiceProviderById);
  }

  void _getServiceProviderById(
    GetServiceProviderByIdEvent event,
    Emitter<ServiceProviderEditProfileState> emit,
  ) async {
    emit(
      state.copyWith(getServiceProviderStatus: StateStatus.loading()),
    );
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
  }
  //
  // void _serviceProviderLoadData(
  //   ServiceProviderLoadData event,
  //   Emitter<ServiceProviderEditProfileState> emit,
  // ) async {
  //   phoneNumberController.text = event.entity.phoneNumber ?? "notProvided".tr();
  //   specializationController.text =
  //       event.entity.specialization ?? "notProvided".tr();
  // }

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
}
