import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/response/service_provider_response.dart';
import 'package:senio_care/features/service_provider/api/models/request/home/service_model.dart';
import 'package:senio_care/features/service_provider/api/models/request/onboarding/service_provider_onboarding_request.dart';
import 'package:senio_care/features/service_provider/api/models/response/home/service_response.dart';

import '../../domain/entity/service_entity.dart';

part 'service_provider_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ServiceProviderApiServices {
  @factoryMethod
  factory ServiceProviderApiServices(Dio dio) = _ServiceProviderApiServices;

  @POST(EndPointsConstants.serviceProvider)
  Future<ServiceProviderResponse> serviceProviderOnboarding(
    @Body() ServiceProviderOnboardingRequest request,
  );

  @PUT(EndPointsConstants.serviceProviderById)
  Future<ServiceProviderResponse> serviceProviderEditProfile(
    @Path('id') String serviceProviderId,
    @Body() ServiceProviderOnboardingRequest request,
  );

  @POST(EndPointsConstants.addService)
  Future<ServiceResponse> addServices(@Body() ServiceRequest request);

  @GET(EndPointsConstants.getService)
  Future<List<ServiceResponse>> getService(@Path('service_provider_id') String id);
}
