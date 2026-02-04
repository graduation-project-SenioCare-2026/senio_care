import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/domain/repository/edit_profile/service_provider_edit_profile_repo.dart';

@injectable
class ServiceProviderEditProfileUseCase{
  final ServiceProviderEditProfileRepo _repo;
  ServiceProviderEditProfileUseCase(this._repo);

  Future<Result<ServiceProviderEntity>> call(
      String id,
      ServiceProviderOnboardingRequest request
      ){
    return _repo.serviceProviderEditProfile(id, request);
  }
}