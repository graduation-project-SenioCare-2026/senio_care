import 'package:equatable/equatable.dart';
import 'package:senio_care/core/user/user_manager.dart';

class UserEntity extends Equatable{
  final String? id;
  final String? name;
  final String? email;
  final String? avatar;
  final UserRole? role;

  const UserEntity ({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.role,
  });

  @override
  List<Object?> get props => [id,name,email,avatar,role];
}