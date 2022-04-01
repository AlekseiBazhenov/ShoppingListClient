import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/events/products_event.dart';
import 'package:shopping_list_client/blocs/products_bloc.dart';
import 'package:shopping_list_client/models/product.dart';
import 'package:shopping_list_client/widgets/products/product_item_widget.dart';

class ProductsWidget extends StatefulWidget {
  ProductsWidget({
    Key? key,
    required this.products,
    required this.shoppingListId,
  }) : super(key: key);

  final List<Product> products;
  final int shoppingListId;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ProductsWidget> {
  late final _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(widget.shoppingListId),
      child: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          Product item = widget.products[index];

          return Dismissible(
            direction: DismissDirection.endToStart,
            resizeDuration: Duration(milliseconds: 200),
            key: ObjectKey(item.id),
            onDismissed: (direction) {
              print("deleted - ${item.id}");
              _delete(item.id);
            },
            background: Container(
              padding: EdgeInsets.only(right: 16.0),
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.deepOrange,
              child: Icon(
                Icons.delete_outlined,
                color: Colors.white,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProductItemWidget(
                  item: item,
                  onStateChanged: (bool newValue) {
                    _change(item.id, newValue, widget.shoppingListId);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _refresh(int shoppingListId) async {
    _bloc.add(FetchProducts(shoppingListId: shoppingListId));
  }

  Future<void> _delete(int itemId) async {
    _bloc.add(DeleteProduct(
      itemId: itemId,
    ));
  }

  Future<void> _change(int itemId, bool bought, int shoppingListId) async {
    _bloc.add(BuyProduct(
      itemId: itemId,
      shoppingListId: shoppingListId,
      bought: bought,
    ));
  }
}
