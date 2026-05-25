import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/auth/api/models/request/register_caregiver_fcm_request.dart';
import 'package:senio_care/features/auth/domain/repository/auth_repo.dart';

@injectable
class RegisterCaregiverFcmUseCase {
  final AuthRepo _repository;

  RegisterCaregiverFcmUseCase(this._repository);
  Future<Result<String>> call(RegisterCaregiverFcmRequest request){
    return _repository.registerCaregiverFcm(request);
  }

}