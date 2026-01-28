import 'package:senio_care/features/auth/domain/entity/caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

class ProfileManager {
  static final ProfileManager _instance = ProfileManager._internal();
  factory ProfileManager() => _instance;
  ProfileManager._internal();

  ElderEntity? elder;
  CaregiverEntity? caregiver;
  ServiceProviderEntity? serviceProvider;

  void clear() {
    elder = null;
    caregiver = null;
    serviceProvider = null;
  }
}