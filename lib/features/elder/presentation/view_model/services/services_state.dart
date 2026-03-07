 import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

class ServicesState {
  final StateStatus<List<ServicesEntity>> getAllServicesState;

  ServicesState({this.getAllServicesState=const StateStatus.loading()});

  ServicesState copyWith({
    StateStatus<List<ServicesEntity>>? getAllServicesState
  } )
  {
    return ServicesState(
      getAllServicesState: getAllServicesState??this.getAllServicesState
    );
  }

}

