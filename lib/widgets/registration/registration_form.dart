import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/registration_bloc.dart';
import 'package:shopping_list_client/blocs/events/registration_event.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  late final _bloc;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<RegistrationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
      child: Column(
        children: [
          TextField(
            controller: _loginController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter login',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter password',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordConfirmationController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Repeat password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _bloc.add(
                StartRegistrationEvent(
                  login: _loginController.text,
                  password: _passwordController.text,
                  passwordConfirmation: _passwordConfirmationController.text,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Register', style: TextStyle(fontSize: 20.0)),
            ),
          )
        ],
      ),
    );
  }
}
