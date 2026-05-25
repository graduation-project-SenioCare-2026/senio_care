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