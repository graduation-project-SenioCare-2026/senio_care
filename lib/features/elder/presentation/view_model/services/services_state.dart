import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';

import '../../../domain/entity/user_profile_entity.dart';

class ServicesState {
  final StateStatus<List<ServicesEntity>> getAllServicesState;
  final Map<String, UserProfileEntity>? usersMap;

  ServicesState({
    this.getAllServicesState = const StateStatus.loading(),
    this.usersMap,
  });

  ServicesState copyWith({
    StateStatus<List<ServicesEntity>>? getAllServicesState,
    Map<String, UserProfileEntity>? usersMap,
  }) {
    return ServicesState(
      getAllServicesState: getAllServicesState ?? this.getAllServicesState,
      usersMap: usersMap ?? this.usersMap,
    );
  }
}
