import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
import 'package:senio_care/features/caregiver/api/models/response/onboarding/caregiver_onboarding_response.dart';
import '../../../../core/constants/end_points_constants.dart';
part 'caregiver_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class CaregiverApiService {
  @factoryMethod
  factory CaregiverApiService(Dio dio) = _CaregiverApiService;
  @POST(EndPointsConstants.caregiverOnboarding)
  Future<CaregiverOnboardingResponse> caregiverOnboarding(@Body() CaregiverOnboardingRequest request);
}
