import 'package:bloc/bloc.dart';
import 'package:shopping_list_client/blocs/states/authorization_state.dart';
import 'package:shopping_list_client/data/user_repository.dart';
import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/user.dart';

import 'events/authorization_event.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final UserRepository repository;

  AuthorizationBloc({required this.repository}) : super(AuthorizationOpened()) {
    on<StartAuthorizationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      StartAuthorizationEvent event, Emitter<AuthorizationState> emit) async {
    try {
      emit(AuthorizationStarted());
      final ApiResponse<User> response =
          await repository.login(event.login, event.password);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        emit(SuccessAuthorization(user: response.data!));
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  void _handleError(Emitter<AuthorizationState> emit, Object error) {
    emit(AuthorizationError(message: error.toString()));
    print(error);
  }
}
