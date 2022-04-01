import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shopping_list_client/blocs/events/shopping_list_event.dart';
import 'package:shopping_list_client/blocs/states/shopping_list_state.dart';
import 'package:shopping_list_client/data/shopping_list_repository.dart';
import 'package:shopping_list_client/models/api_response.dart';
import 'package:shopping_list_client/models/shopping_list.dart';
import 'package:shopping_list_client/models/shopping_lists.dart';
import 'package:shopping_list_client/models/success_result.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ShoppingListRepository repository;

  ShoppingListBloc({required this.repository}) : super(ShoppingListLoading()) {
    on<FetchShoppingLists>(_onFetchShoppingListsEvent);
    on<DeleteShoppingList>(_onDeleteShoppingListEvent);
    on<AddShoppingList>(_onAddShoppingListEvent);
  }

  Future<void> _onFetchShoppingListsEvent(
      FetchShoppingLists event, Emitter<ShoppingListState> emit) async {
    try {
      final ApiResponse<ShoppingLists> response = await repository.fetch();
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        if (response.data!.shoppingLists.isEmpty) {
          emit(ShoppingListEmpty());
        } else {
          emit(
              ShoppingListsLoaded(shoppingLists: response.data!.shoppingLists));
        }
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  Future<void> _onDeleteShoppingListEvent(
      DeleteShoppingList event, Emitter<ShoppingListState> emit) async {
    try {
      ApiResponse<SuccessResult> response =
          await repository.delete(event.itemId);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  Future<void> _onAddShoppingListEvent(
      AddShoppingList event, Emitter<ShoppingListState> emit) async {
    try {
      ApiResponse<ShoppingList> response = await repository.add(event.item);
      if (response.error != null) {
        _handleError(emit, response.error!.details);
      } else {
        add(FetchShoppingLists());
      }
    } catch (error) {
      _handleError(emit, error);
    }
  }

  void _handleError(Emitter<ShoppingListState> emit, Object error) {
    emit(ShoppingListError(message: error.toString()));
    print(error);
  }
}
