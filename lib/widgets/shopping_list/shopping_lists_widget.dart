import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/events/shopping_list_event.dart';
import 'package:shopping_list_client/blocs/shopping_list_bloc.dart';
import 'package:shopping_list_client/models/shopping_list.dart';
import 'package:shopping_list_client/widgets/shopping_list/shopping_list_item_widget.dart';

class ShoppingListsWidget extends StatefulWidget {
  ShoppingListsWidget({
    Key? key,
    required this.shoppingLists,
  }) : super(key: key);

  final List<ShoppingList> shoppingLists;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingListsWidget> {
  late final _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<ShoppingListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: widget.shoppingLists.length,
        itemBuilder: (context, index) {
          ShoppingList item = widget.shoppingLists[index];

          return Dismissible(
            direction: DismissDirection.endToStart,
            resizeDuration: Duration(milliseconds: 200),
            key: ObjectKey(item.id),
            onDismissed: (direction) {
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
                ShoppingListItemWidget(
                  item: item,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    _bloc.add(FetchShoppingLists());
  }

  Future<void> _delete(int itemId) async {
    _bloc.add(DeleteShoppingList(
      itemId: itemId,
    ));
  }
}
