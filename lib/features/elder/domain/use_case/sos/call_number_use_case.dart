import 'package:injectable/injectable.dart';
import 'package:senio_care/features/elder/domain/repository/sos/sos_repo.dart';

@LazySingleton()
class CallNumberUseCase {
  final SosRepo sosRepo ;

  CallNumberUseCase(this.sosRepo);

  Future<void> call(String number) {
    return sosRepo.callNumber(number);
  }
}