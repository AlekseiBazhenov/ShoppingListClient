import 'package:equatable/equatable.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

class FetchShoppingLists extends ShoppingListEvent {}

class DeleteShoppingList extends ShoppingListEvent {
  final int itemId;

  const DeleteShoppingList({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

class AddShoppingList extends ShoppingListEvent {
  final String item;

  const AddShoppingList({required this.item});

  @override
  List<Object> get props => [item];
}
