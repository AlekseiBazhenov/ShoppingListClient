import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/authorization_bloc.dart';
import 'package:shopping_list_client/data/user_repository.dart';
import 'package:shopping_list_client/blocs/states/authorization_state.dart';
import 'package:shopping_list_client/widgets/auth/auth_form.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({
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
        create: (context) => AuthorizationBloc(repository: repository),
        child: BlocListener<AuthorizationBloc, AuthorizationState>(
          listener: (BuildContext context, AuthorizationState state) {
            if (state is SuccessAuthorization) {
              Navigator.pushNamedAndRemoveUntil(context, '/main', (r) => false);
            }
          },
          child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
            builder: (context, state) {
              if (state is AuthorizationOpened) {
                return AuthForm();
              } else if (state is AuthorizationStarted) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthorizationError) {
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
