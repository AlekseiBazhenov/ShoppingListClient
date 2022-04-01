import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list_client/data/api_client.dart';
import 'package:shopping_list_client/data/shopping_list_repository.dart';
import 'package:shopping_list_client/data/user_repository.dart';

import 'data/products_repository.dart';
import 'debug_bloc_observer.dart';
import 'shopping_list_app.dart';

Future<void> main() async {
  Bloc.observer = DebugBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  var apiClient = ApiClient(
    httpClient: http.Client(),
  );

  final UserRepository userRepository = UserRepository(apiClient: apiClient);
  final ShoppingListRepository shoppingListRepository =
      ShoppingListRepository(apiClient: apiClient);
  final ProductsRepository productsRepository =
      ProductsRepository(apiClient: apiClient);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool authorized = (prefs.getString('auth') ?? "").isNotEmpty;

  runApp(ShoppingListApp(
    userRepository: userRepository,
    shoppingListRepository: shoppingListRepository,
    productsRepository: productsRepository,
    authorized: authorized,
  ));
}
