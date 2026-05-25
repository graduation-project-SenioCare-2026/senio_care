abstract class HealthReportsEvent {}

class GetReports extends HealthReportsEvent {
  final String id;
  GetReports(this.id);
}
