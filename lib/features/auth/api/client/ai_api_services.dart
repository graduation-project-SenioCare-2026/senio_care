import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/request/register_caregiver_fcm_request.dart';

part 'ai_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.aiSenioCareUrl)
@injectable
abstract class AiApiServices {
  @factoryMethod
  factory AiApiServices(Dio dio) = _AiApiServices;

  @POST(EndPointsConstants.registerCaregiverFcm)
  Future<String> registerCaregiverFcm(
      @Body() RegisterCaregiverFcmRequest request
      );

}
