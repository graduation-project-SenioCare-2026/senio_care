import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';
import 'package:senio_care/features/elder/api/models/response/onboarding/elder_onboarding_response.dart';

part 'elder_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ElderApiServices {

  @factoryMethod
  factory ElderApiServices(Dio dio) = _ElderApiServices;

  @POST(EndPointsConstants.postElder)
  Future<ElderOnboardingResponse> submitElderOnboardingData(
      @Body() ElderOnboardingRequest request
      );

}
