import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';

abstract class HealthReportsEvent {}

class GetReports extends HealthReportsEvent {
  final String id;
  GetReports(this.id);
}
class GetReportDetails extends HealthReportsEvent {
  final String reportId;
  final String userId;
  GetReportDetails(this.userId,this.reportId);
}

class CreateReportEvent extends HealthReportsEvent{
  final CreateReportRequest request;
  CreateReportEvent(this.request);
}