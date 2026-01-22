import 'package:equatable/equatable.dart';

class MobilityStatusEntity extends Equatable{
  final String ar;
  final String en;

  const MobilityStatusEntity({
    required this.ar,
    required this.en,
  });


  @override
  List<Object?> get props => [en,ar];
}
