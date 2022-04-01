import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/authorization_bloc.dart';
import 'package:shopping_list_client/blocs/events/authorization_event.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  late final _bloc;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthorizationBloc>(context);
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _bloc.add(
                StartAuthorizationEvent(
                  login: _loginController.text,
                  password: _passwordController.text,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Sign In', style: TextStyle(fontSize: 20.0)),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registration');
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Sign Up', style: TextStyle(fontSize: 20.0)),
            ),
          )
        ],
      ),
    );
  }
}
