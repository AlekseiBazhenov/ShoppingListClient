import 'package:equatable/equatable.dart';
import 'package:shopping_list_client/models/shopping_list.dart';

class ShoppingLists extends Equatable {

  final List<ShoppingList> shoppingLists;

  ShoppingLists({required this.shoppingLists});

  factory ShoppingLists.fromJson(Map<String, dynamic> data) {
    List<ShoppingList> items = data['shoppingLists']
        .map<ShoppingList>((json) => ShoppingList.fromJson(json))
        .toList();
    return ShoppingLists(
      shoppingLists: items,
    );
  }

  @override
  List<Object> get props => [shoppingLists.length];

  @override
  String toString() {
    return '{ shoppingLists: $shoppingLists }';
  }
}
