import 'dart:async';

import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/shopping_list.dart';
import 'package:shopping_list_client/models/shopping_lists.dart';
import 'package:shopping_list_client/models/success_result.dart';

import 'api_client.dart';

class ShoppingListRepository {
  final ApiClient apiClient;

  ShoppingListRepository({required this.apiClient});

  Future<ApiResponse<ShoppingLists>> fetch() async {
    return await apiClient.fetchShoppingLists();
  }

  Future<ApiResponse<ShoppingList>> add(String name) async {
    return await apiClient.addShoppingList(name);
  }

  Future<ApiResponse<ShoppingList>> edit(
      int id, String name) async {
    return await apiClient.editShoppingList(id, name);
  }

  Future<ApiResponse<SuccessResult>> delete(int id) async {
    return await apiClient.deleteShoppingList(id);
  }
}
