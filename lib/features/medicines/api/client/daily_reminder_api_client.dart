import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:senio_care/core/constants/end_points_constants.dart';
import 'package:senio_care/features/medicines/api/models/request/update_reminder_state_request.dart';
import 'package:senio_care/features/medicines/api/models/response/daily_reminder_response.dart';
import 'package:senio_care/features/medicines/api/models/request/medicine_request.dart';
import 'package:senio_care/features/medicines/api/models/response/medicine_response.dart';

part 'daily_reminder_api_client.g.dart';

@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class DailyReminderApiClient {
  @factoryMethod
  factory DailyReminderApiClient(Dio dio) = _DailyReminderApiClient;


  @GET(EndPointsConstants.dailyReminderByDate)
  Future<List<DailyReminderResponse>> getDailyReminders(
      @Path("elder_id") String elderId,
      @Query("date") String date
      );
  @POST(EndPointsConstants.addMedicine)
  Future<MedicineResponse> addMedicine(@Body() MedicineRequest request);
}

  @PUT(EndPointsConstants.updateReminderState)
  Future<MedicineResponse> updateState(
      @Path("id") String id,
      @Body() UpdateReminderStateRequest request
      );

  @DELETE(EndPointsConstants.deleteReminder)
  Future<String> deleteReminder(
      @Path("id") String id,
      );
}