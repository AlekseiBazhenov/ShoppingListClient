import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();
}

class StartAuthorizationEvent extends AuthorizationEvent {
  final String login;
  final String password;

  const StartAuthorizationEvent({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [];
}
