import 'package:equatable/equatable.dart';
import 'package:shopping_list_client/models/product.dart';

class Products extends Equatable {

  final List<Product> products;

  Products({required this.products});

  factory Products.fromJson(Map<String, dynamic> data) {
    List<Product> items = data['products']
        .map<Product>((json) => Product.fromJson(json))
        .toList();
    return Products(
      products: items,
    );
  }

  @override
  List<Object> get props => [products.length];

  @override
  String toString() {
    return '{ products: $products }';
  }
}
