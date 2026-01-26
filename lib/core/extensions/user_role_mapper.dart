import 'package:senio_care/core/user/user_manager.dart';

extension UserRoleMapper on String? {
  UserRole? toUserRole() {
    switch (this) {
      case 'elder':
        return UserRole.elder;
      case 'caregiver':
        return UserRole.caregiver;
      case 'serviceProvider':
      case 'service_provider':
        return UserRole.serviceProvider;
      default:
        return null;
    }
  }
}