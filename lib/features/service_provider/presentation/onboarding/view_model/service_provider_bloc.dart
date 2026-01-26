import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/domain/use_case/onboarding/submit_service_provider_onboarding_data.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_event.dart';
import 'package:senio_care/features/service_provider/presentation/onboarding/view_model/service_provider_state.dart';

@injectable
class ServiceProviderOnboardingBloc
    extends
        Bloc<ServiceProviderOnboardingEvent, ServiceProviderOnboardingState> {

  final SubmitServiceProviderOnboardingData _serviceProviderOnboardingData;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final  phoneNumberController = TextEditingController();
  final  specializationController = TextEditingController();

  ServiceProviderOnboardingBloc(this._serviceProviderOnboardingData)
    : super(ServiceProviderOnboardingState()) {
    on<ServiceProviderSubmitDataEvent>(_serviceProviderOnboardingEvent);
  }

  Future<void> _serviceProviderOnboardingEvent(
    ServiceProviderSubmitDataEvent event,
    Emitter<ServiceProviderOnboardingState> emit,
  ) async {
    emit(state.copyWith(serviceProviderOnboardingState: StateStatus.loading()));
    final result = await _serviceProviderOnboardingData.call(event.request);
    switch (result) {
      case Success<ServiceProviderEntity>():
        emit(
          state.copyWith(
            serviceProviderOnboardingState: StateStatus.success(result.data),
          ),
        );

      case Failure<ServiceProviderEntity>():
        emit(
          state.copyWith(
            serviceProviderOnboardingState: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
    }
  }
}
