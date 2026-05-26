import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';
import 'package:senio_care/features/elder/api/models/response/health_report_response.dart';

import '../../../../core/constants/end_points_constants.dart';
import '../models/response/health_report_details_response.dart';
part 'health_reports_services.g.dart';

@RestApi(baseUrl: EndPointsConstants.aiSenioCareUrl)
@injectable
abstract class HealthReportsServices {
  @factoryMethod
  factory HealthReportsServices(Dio dio) = _HealthReportsServices;

  @GET(EndPointsConstants.getReports)
  Future<HealthReportListResponse> getReports(@Path('user_id') String userId);

  @GET(EndPointsConstants.getReportsDetails)
  Future<HealthReportDetailsListResponse> getReportDetails(
    @Path('user_id') String userId,
    @Path('report_id') String reportId,
  );

  @POST(EndPointsConstants.createReport)
  Future<String> createReport(
      @Body() CreateReportRequest request
      );
}
