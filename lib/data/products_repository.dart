import 'dart:async';

import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/product.dart';
import 'package:shopping_list_client/models/products.dart';
import 'package:shopping_list_client/models/success_result.dart';

import 'api_client.dart';

class ProductsRepository {
  final ApiClient apiClient;

  ProductsRepository({required this.apiClient});

  Future<ApiResponse<Products>> fetch(int id) async {
    return await apiClient.fetchShoppingListProducts(id);
  }

  Future<ApiResponse<Product>> add(String item, int shoppingListId) async {
    return await apiClient.addItem(item, shoppingListId);
  }

  Future<ApiResponse<SuccessResult>> delete(int itemId) async {
    return await apiClient.deleteItem(itemId);
  }

  Future<ApiResponse<Product>> buy(
    int itemId,
    int shoppingListId,
    bool bought,
  ) async {
    return await apiClient.buyItem(
      itemId,
      shoppingListId,
      bought,
    );
  }
}
