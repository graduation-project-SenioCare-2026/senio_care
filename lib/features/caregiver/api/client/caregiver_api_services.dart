import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/response/caregiver_response.dart';
import 'package:senio_care/features/caregiver/api/models/request/onboarding/caregiver_onboarding_request.dart';
part 'caregiver_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class CaregiverApiService {
  @factoryMethod
  factory CaregiverApiService(Dio dio) = _CaregiverApiService;

  @POST(EndPointsConstants.caregiver)
  Future<CaregiverResponse> caregiverOnboarding(
    @Body() CaregiverOnboardingRequest request,
  );

  @PUT(EndPointsConstants.caregiverById)
  Future<CaregiverResponse> caregiverEditProfile(
      @Path('id') String caregiverId,
      @Body() CaregiverOnboardingRequest request,
      );
}
