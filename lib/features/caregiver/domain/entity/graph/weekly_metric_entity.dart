import 'package:equatable/equatable.dart';

class WeeklyMetricEntity  extends Equatable{
  final String day;
  final double value;

  const WeeklyMetricEntity({
    required this.day,
    required this.value,
  });

  @override
  List<Object?> get props => [day,value];
}
