import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/domain/use_case/get_caregiver_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_elder_by_id_use_case.dart';
import 'package:senio_care/features/auth/domain/use_case/get_service_provider_by_id_use_case.dart';

@lazySingleton
class GetProfileUseCaseResolver {
  final GetElderByIdUseCase elder;
  final GetCaregiverByIdUseCase caregiver;
  final GetServiceProviderByIdUseCase serviceProvider;

  GetProfileUseCaseResolver(
      this.elder,
      this.caregiver,
      this.serviceProvider,
      );

  Future<Result<dynamic>> call(UserRole role,String id) {
    switch (role) {
      case UserRole.elder:
        return elder(id);
      case UserRole.caregiver:
        return caregiver(id);
      case UserRole.serviceProvider:
        return serviceProvider(id);
    }
  }
}