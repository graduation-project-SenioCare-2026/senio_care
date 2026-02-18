import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/data/data_source/remote/edit_profile/service_provider_edit_profile_remote_ds.dart';
import 'package:senio_care/features/service_provider/domain/repository/edit_profile/service_provider_edit_profile_repo.dart';

@Injectable(as: ServiceProviderEditProfileRepo)
class ServiceProviderEditProfileRepoImpl
    implements ServiceProviderEditProfileRepo {
  final ServiceProviderEditProfileRemoteDS _editProfileRemoteDS;
  ServiceProviderEditProfileRepoImpl(this._editProfileRemoteDS);
  @override
  Future<Result<ServiceProviderEntity>> serviceProviderEditProfile(
    String id,
    ServiceProviderOnboardingRequest request,
  ) {
    return _editProfileRemoteDS.serviceProviderEditProfileRemoteDS(id, request);
  }
}
