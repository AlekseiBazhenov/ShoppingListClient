import 'package:equatable/equatable.dart';
import 'package:shopping_list_client/models/user.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

class AuthorizationOpened extends AuthorizationState {}

class AuthorizationStarted extends AuthorizationState {}

class AuthorizationError extends AuthorizationState {
  final String message;

  const AuthorizationError({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessAuthorization extends AuthorizationState {
  final User user;

  const SuccessAuthorization({required this.user});

  @override
  List<Object> get props => [user.id];
}
