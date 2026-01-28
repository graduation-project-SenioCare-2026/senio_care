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



  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar': avatar,
    'role': role?.name,
  };


  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    avatar: json['avatar'],
    role: json['role'] != null ? UserRole.values.firstWhere((r) => r.name == json['role']) : null,
  );

  @override
  List<Object?> get props => [id,name,email,avatar,role];
}