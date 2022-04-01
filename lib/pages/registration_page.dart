import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/registration_bloc.dart';
import 'package:shopping_list_client/blocs/states/registration_state.dart';
import 'package:shopping_list_client/data/user_repository.dart';
import 'package:shopping_list_client/widgets/registration/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({
    Key? key,
    required this.title,
    required this.repository,
  }) : super(key: key);

  final String title;
  final UserRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
        create: (context) => RegistrationBloc(repository: repository),
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (BuildContext context, RegistrationState state) {
            if (state is SuccessRegistration) {
              Navigator.pushNamedAndRemoveUntil(context, '/main', (r) => false);
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if (state is RegistrationOpened) {
                return RegistrationForm();
              } else if (state is RegistrationStarted) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RegistrationError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}
