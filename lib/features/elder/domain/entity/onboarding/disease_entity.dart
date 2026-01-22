import 'package:equatable/equatable.dart';

class DiseaseEntity extends Equatable{
  final String ar;
  final String en;

  const DiseaseEntity({
    required this.ar,
    required this.en,
  });


  @override
  List<Object?> get props => [en,ar];
}
