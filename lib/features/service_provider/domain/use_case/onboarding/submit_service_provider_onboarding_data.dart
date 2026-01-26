import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/domain/repository/onboarding/service_provider_onboarding_repo.dart';

@injectable
class SubmitServiceProviderOnboardingData {

  final ServiceProviderOnboardingRepo _repo;
  SubmitServiceProviderOnboardingData(this._repo);

  Future<Result<ServiceProviderEntity>> call(
    ServiceProviderOnboardingRequest request,
  ) {
    return _repo.submitServiceProviderOnboardingData(request);
  }
}
