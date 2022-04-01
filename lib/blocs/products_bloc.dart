import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shopping_list_client/blocs/events/products_event.dart';
import 'package:shopping_list_client/blocs/states/products_state.dart';
import 'package:shopping_list_client/data/products_repository.dart';
import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/product.dart';
import 'package:shopping_list_client/models/products.dart';
import 'package:shopping_list_client/models/success_result.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc({required this.repository}) : super(ProductsListLoading()) {
    on<FetchProducts>(_onFetchProductsEvent);
    on<DeleteProduct>(_onDeleteShoppingListItemEvent);
    on<BuyProduct>(_onBuyShoppingListItemEvent);
    on<AddProduct>(_onAddShoppingListItemEvent);
  }

  Future<void> _onFetchProductsEvent(
      FetchProducts event, Emitter<ProductsState> emit) async {
    try {
      final ApiResponse<Products> response =
          await repository.fetch(event.shoppingListId);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        if (response.data!.products.isEmpty) {
          emit(ProductsListEmpty());
        } else {
          emit(ProductsLoaded(products: response.data!.products));
        }
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  Future<void> _onDeleteShoppingListItemEvent(
      DeleteProduct event, Emitter<ProductsState> emit) async {
    try {
      ApiResponse<SuccessResult> response = await repository.delete(event.itemId);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  Future<void> _onBuyShoppingListItemEvent(
      BuyProduct event, Emitter<ProductsState> emit) async {
    try {
      final ApiResponse<Product> response = await repository.buy(
          event.itemId, event.shoppingListId, event.bought);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  Future<void> _onAddShoppingListItemEvent(
      AddProduct event, Emitter<ProductsState> emit) async {
    try {
      ApiResponse<Product> response = await repository.add(event.item, event.shoppingListId);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        add(FetchProducts(shoppingListId: event.shoppingListId));
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  void _handleError(Emitter<ProductsState> emit, Object error) {
    emit(ProductsError(message: error.toString()));
    print(error);
  }
}
