import 'package:bloc/bloc.dart';
import 'package:shopping_list_client/blocs/events/registration_event.dart';
import 'package:shopping_list_client/blocs/states/registration_state.dart';
import 'package:shopping_list_client/data/user_repository.dart';
import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/user.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository repository;

  RegistrationBloc({required this.repository}) : super(RegistrationOpened()) {
    on<StartRegistrationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      StartRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationStarted());
      final ApiResponse<User> response = await repository.registration(
        event.login,
        event.password,
        event.passwordConfirmation,
      );
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        emit(SuccessRegistration(user: response.data!));
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  void _handleError(Emitter<RegistrationState> emit, Object error) {
    emit(RegistrationError(message: error.toString()));
    print(error);
  }
}
