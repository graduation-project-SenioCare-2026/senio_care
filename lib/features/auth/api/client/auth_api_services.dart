import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/auth/api/models/request/google_sign_in_request.dart';
import 'package:senio_care/features/auth/api/models/response/elder_response.dart';
import 'package:senio_care/features/auth/api/models/response/get_caregiver_response.dart';
import 'package:senio_care/features/auth/api/models/response/google_sign_in_response.dart';
import 'package:senio_care/features/auth/api/models/response/service_provider_response.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class AuthApiServices {
  @factoryMethod
  factory AuthApiServices(Dio dio) = _AuthApiServices;

  @POST(EndPointsConstants.googleSignIn)
  Future<GoogleSignInResponse> signInWithGoogle(
      @Body() GoogleSignInRequest request
      );

  @GET(EndPointsConstants.elderById)
  Future<ElderResponse> getElderById(
        @Path('id') String id
      );

  @GET(EndPointsConstants.caregiverById)
  Future<GetCaregiverResponse> getCaregiverById(
      @Path('id') String id
      );

  @GET(EndPointsConstants.serviceProviderById)
  Future<ServiceProviderResponse> getServiceProviderById(
      @Path('id') String id
      );
}
