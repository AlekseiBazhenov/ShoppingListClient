import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_client/models/shopping_list.dart';
import 'package:shopping_list_client/pages/args/products_route_arguments.dart';

class ShoppingListItemWidget extends StatefulWidget {
  const ShoppingListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ShoppingList item;

  @override
  State<ShoppingListItemWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => {
          _openProducts(context),
        },
        child: Text(
          '${widget.item.name}  (${widget.item.productsCount})',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> _openProducts(BuildContext context) {
    return Navigator.pushNamed(
      context,
      '/products',
      arguments: ProductsRouteArguments(
        shoppingListId: widget.item.id,
        shoppingListName: widget.item.name,
      ),
    );
  }
}
