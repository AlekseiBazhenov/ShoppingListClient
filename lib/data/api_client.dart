import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/product.dart';
import 'package:shopping_list_client/models/products.dart';
import 'package:shopping_list_client/models/shopping_list.dart';
import 'package:shopping_list_client/models/shopping_lists.dart';
import 'package:shopping_list_client/models/success_result.dart';
import 'package:shopping_list_client/models/user.dart';

class ApiClient {
  final _baseUrl = 'http://192.168.0.100:8080/api'; // todo

  final http.Client httpClient;

  ApiClient({
    required this.httpClient,
  });

  // ------ USER ------ //

  Future<ApiResponse<User>> login(
    String login,
    String password,
  ) async {
    final url = '$_baseUrl/users';

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$password'));

    final response = await this.httpClient.get(
      Uri.parse(url),
      headers: <String, String>{'Authorization': basicAuth},
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await _saveAccessToken(basicAuth);
      return ApiResponse<User>.fromJson(
        json,
        (data) => User.fromJson(data),
      );
    } else {
      return ApiResponse<User>.errorFromJson(json);
    }
  }

  Future<ApiResponse<User>> registration(
    String login,
    String password,
    String passwordConfirmation,
  ) async {
    final url = '$_baseUrl/users';

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$password'));

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: <String, String>{'content-type': 'application/json'},
          body: jsonEncode(<String, String>{
            'username': login,
            'password': password,
            'passwordConfirmation': passwordConfirmation,
          }),
        );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await _saveAccessToken(basicAuth);
      return ApiResponse<User>.fromJson(
        json,
        (data) => User.fromJson(data),
      );
    } else {
      return ApiResponse<User>.errorFromJson(json);
    }
  }

  // ------ SHOPPING LISTS ------ //

  Future<ApiResponse<ShoppingLists>> fetchShoppingLists() async {
    final url = '$_baseUrl/shopping-lists';

    String auth = await _getAccessToken();
    final response = await this.httpClient.get(
      Uri.parse(url),
      headers: <String, String>{'Authorization': auth},
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<ShoppingLists>.fromJson(
        json,
        (data) => ShoppingLists.fromJson(data),
      );
    } else {
      return ApiResponse<ShoppingLists>.errorFromJson(json);
    }
  }

  Future<ApiResponse<ShoppingList>> addShoppingList(String name) async {
    final url = '$_baseUrl/shopping-lists';

    String auth = await _getAccessToken();
    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: <String, String>{
            'Authorization': auth,
            'content-type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'name': name,
          }),
        );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<ShoppingList>.fromJson(
        json,
        (data) => ShoppingList.fromJson(data),
      );
    } else {
      return ApiResponse<ShoppingList>.errorFromJson(json);
    }
  }

  Future<ApiResponse<ShoppingList>> editShoppingList(
      int id, String name) async {
    final url = '$_baseUrl/shopping-lists/$id';

    String auth = await _getAccessToken();
    final response = await this.httpClient.put(
          Uri.parse(url),
          headers: <String, String>{
            'Authorization': auth,
            'content-type': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'name': name,
          }),
        );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<ShoppingList>.fromJson(
        json,
        (data) => ShoppingList.fromJson(data),
      );
    } else {
      return ApiResponse<ShoppingList>.errorFromJson(json);
    }
  }

  Future<ApiResponse<SuccessResult>> deleteShoppingList(int id) async {
    final url = '$_baseUrl/shopping-lists/$id';

    String auth = await _getAccessToken();
    final response = await this.httpClient.delete(
      Uri.parse(url),
      headers: <String, String>{'Authorization': auth},
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<SuccessResult>.fromJson(
        json,
        (data) => SuccessResult.fromJson(data),
      );
    } else {
      return ApiResponse<SuccessResult>.errorFromJson(json);
    }
  }

  Future<ApiResponse<Products>> fetchShoppingListProducts(int id) async {
    final url = '$_baseUrl/shopping-lists/$id/products';

    String auth = await _getAccessToken();
    final response = await this.httpClient.get(
      Uri.parse(url),
      headers: <String, String>{'Authorization': auth},
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<Products>.fromJson(
        json,
        (data) => Products.fromJson(data),
      );
    } else {
      return ApiResponse<Products>.errorFromJson(json);
    }
  }

  // ------ PRODUCTS ------ //

  Future<ApiResponse<Product>> addItem(String item, int shoppingListId) async {
    final url = '$_baseUrl/items';

    String auth = await _getAccessToken();
    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: <String, String>{
            'Authorization': auth,
            'content-type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'name': item,
            'shoppingListId': shoppingListId
          }),
        );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<Product>.fromJson(
        json,
        (data) => Product.fromJson(data),
      );
    } else {
      return ApiResponse<Product>.errorFromJson(json);
    }
  }

  Future<ApiResponse<SuccessResult>> deleteItem(int id) async {
    final url = '$_baseUrl/items/$id';

    String auth = await _getAccessToken();
    final response = await this.httpClient.delete(
      Uri.parse(url),
      headers: <String, String>{'Authorization': auth},
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<SuccessResult>.fromJson(
        json,
        (data) => SuccessResult.fromJson(data),
      );
    } else {
      return ApiResponse<SuccessResult>.errorFromJson(json);
    }
  }

  Future<ApiResponse<Product>> buyItem(
      int id, int shoppingListId, bool bought) async {
    final url = '$_baseUrl/items/$id';

    String auth = await _getAccessToken();
    final response = await this.httpClient.put(
          Uri.parse(url),
          headers: <String, String>{
            'Authorization': auth,
            'content-type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'bought': bought,
            'shoppingListId': shoppingListId,
          }),
        );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<Product>.fromJson(
        json,
        (data) => Product.fromJson(data),
      );
    } else {
      return ApiResponse<Product>.errorFromJson(json);
    }
  }

  // ------ USER PREFS ------ //

  Future<void> _saveAccessToken(String basicAuth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // todo use JSESSIONID? enable in backend
    prefs.setString('auth', basicAuth);
  }

  Future<String> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth') ?? "";
  }
}
