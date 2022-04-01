import 'package:flutter/material.dart';
import 'package:shopping_list_client/data/shopping_list_repository.dart';
import 'package:shopping_list_client/pages/shopping_lists_page.dart';

import 'data/products_repository.dart';
import 'data/user_repository.dart';
import 'pages/authorization_page.dart';
import 'pages/products_page.dart';
import 'pages/registration_page.dart';

class ShoppingListApp extends StatelessWidget {
  final UserRepository userRepository;
  final ShoppingListRepository shoppingListRepository;
  final ProductsRepository productsRepository;

  final bool authorized;

  ShoppingListApp({
    Key? key,
    required this.userRepository,
    required this.shoppingListRepository,
    required this.productsRepository,
    required this.authorized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: authorized ? "/main" : '/login',
      routes: {
        '/login': (context) => AuthorizationPage(
              title: 'Authorization',
              repository: userRepository,
            ),
        '/registration': (context) => RegistrationPage(
              title: 'Registration',
              repository: userRepository,
            ),
        '/main': (context) => ShoppingListsPage(
              title: 'Shopping List',
              repository: shoppingListRepository,
            ),
        '/products': (context) => ProductsPage(
              repository: productsRepository,
            ),
      },
    );
  }
}
