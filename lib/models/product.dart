import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final bool bought;

  Product({
    required this.id,
    required this.name,
    required this.bought,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      bought: json['bought'],
    );
  }

  @override
  List<Object> get props => [id, name, bought];

  @override
  String toString() {
    return '{ id: $id, name: $name, bought: $bought }';
  }
}
