import 'package:equatable/equatable.dart';

class ShoppingList extends Equatable {
  final int id;
  final String name;
  final int productsCount;

  ShoppingList({
    required this.id,
    required this.name,
    required this.productsCount,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> jsonShoppingList) {
    return ShoppingList(
      id: jsonShoppingList['id'],
      name: jsonShoppingList['name'],
      productsCount: jsonShoppingList['productsCount'],
    );
  }

  @override
  List<Object> get props => [id, name, productsCount];

  @override
  String toString() {
    return '{ id: $id, name: $name, productsCount: $productsCount }';
  }
}
