import 'package:equatable/equatable.dart';
import 'package:shopping_list_client/models/user.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationOpened extends RegistrationState {}

class RegistrationStarted extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String message;

  const RegistrationError({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessRegistration extends RegistrationState {
  final User user;

  const SuccessRegistration({required this.user});

  @override
  List<Object> get props => [user.id];
}
