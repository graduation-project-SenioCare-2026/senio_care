import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
import 'package:senio_care/features/elder/api/models/request/onboarding/elder_onboarding_request.dart';

part 'elder_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class ElderApiServices {

  @factoryMethod
  factory ElderApiServices(Dio dio) = _ElderApiServices;

  @POST(EndPointsConstants.elder)
  Future<ElderResponse> submitElderOnboardingData(
      @Body() ElderOnboardingRequest request
      );

  @PUT(EndPointsConstants.elderById)
  Future<ElderResponse> editElder(
      @Path('id') String id,
      @Body() ElderOnboardingRequest request

      );


}
