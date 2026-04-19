import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String sessionId;
  final String appName;
  final String userId;


  const SessionEntity({
    required this.sessionId,
    required this.appName,
    required this.userId,
  });

  @override
  List<Object?> get props => [sessionId, appName, userId];
}
