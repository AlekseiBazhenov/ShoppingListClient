import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class StartRegistrationEvent extends RegistrationEvent {
  final String login;
  final String password;
  final String passwordConfirmation;

  const StartRegistrationEvent({
    required this.login,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [];
}
