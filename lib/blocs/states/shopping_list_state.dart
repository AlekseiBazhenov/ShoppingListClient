import 'package:equatable/equatable.dart';
import 'package:shopping_list_client/models/shopping_list.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

class ShoppingListEmpty extends ShoppingListState {}

class ShoppingListLoading extends ShoppingListState {}

class ShoppingListError extends ShoppingListState {
  final String message;

  const ShoppingListError({required this.message});

  @override
  List<Object> get props => [message];
}

class ShoppingListsLoaded extends ShoppingListState {
  final List<ShoppingList> shoppingLists;

  const ShoppingListsLoaded({required this.shoppingLists});

  @override
  List<Object> get props => [
        shoppingLists.length,
        shoppingLists.map((e) => e.productsCount),
      ];
}
