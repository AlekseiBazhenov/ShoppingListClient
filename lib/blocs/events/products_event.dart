import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductsEvent {
  final int shoppingListId;

  const FetchProducts({required this.shoppingListId});

  @override
  List<Object> get props => [shoppingListId];
}

class DeleteProduct extends ProductsEvent {
  final int itemId;

  const DeleteProduct({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

class BuyProduct extends ProductsEvent {
  final int itemId;
  final int shoppingListId;
  final bool bought;

  const BuyProduct({
    required this.itemId,
    required this.shoppingListId,
    required this.bought,
  });

  @override
  List<Object> get props => [itemId, bought];
}

class AddProduct extends ProductsEvent {
  final String item;
  final int shoppingListId;

  const AddProduct({
    required this.item,
    required this.shoppingListId,
  });

  @override
  List<Object> get props => [item];
}
