import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/auth/domain/entity/get_caregiver_entity.dart';
import 'package:senio_care/features/auth/domain/entity/service_provider_entity.dart';

class ProfileManager {
  static final ProfileManager _instance = ProfileManager._internal();
  factory ProfileManager() => _instance;
  ProfileManager._internal();

  ElderEntity? elder;
  GetCaregiverEntity? caregiver;
  ServiceProviderEntity? serviceProvider;

  void clear() {
    elder = null;
    caregiver = null;
    serviceProvider = null;
  }
}