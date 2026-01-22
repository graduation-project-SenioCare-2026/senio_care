import 'package:equatable/equatable.dart';

class AllergyEntity extends Equatable{
  final String ar;
  final String en;

  const AllergyEntity({
    required this.ar,
    required this.en,
  });

  @override
  List<Object?> get props => [en,ar];
}