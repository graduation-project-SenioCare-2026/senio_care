import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/api/models/response/onboarding/service_provider_onboarding_response.dart';

import '../../../../core/constants/end_points_constants.dart';
part 'service_provider_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ServiceProviderApiServices {
  @factoryMethod
  factory ServiceProviderApiServices(Dio dio) = _ServiceProviderApiServices;

  @POST(EndPointsConstants.serviceProviderOnboarding)
  Future<ServiceProviderOnboardingResponse> serviceProviderOnboarding(
    @Body() ServiceProviderOnboardingRequest request,
  );
}
