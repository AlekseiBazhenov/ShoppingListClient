import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/events/shopping_list_event.dart';
import 'package:shopping_list_client/blocs/shopping_list_bloc.dart';
import 'package:shopping_list_client/blocs/states/shopping_list_state.dart';
import 'package:shopping_list_client/data/shopping_list_repository.dart';
import 'package:shopping_list_client/widgets/common/input_dialog.dart';
import 'package:shopping_list_client/widgets/shopping_list/shopping_lists_widget.dart';

class ShoppingListsPage extends StatefulWidget {
  ShoppingListsPage({
    Key? key,
    required this.title,
    required this.repository,
  }) : super(key: key);

  final String title;
  final ShoppingListRepository repository;

  @override
  _ShoppingListsPageState createState() => _ShoppingListsPageState();
}

class _ShoppingListsPageState extends State<ShoppingListsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingListBloc(repository: widget.repository)
        ..add(FetchShoppingLists()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: BlocBuilder<ShoppingListBloc, ShoppingListState>(
              builder: (context, state) {
                if (state is ShoppingListsLoaded) {
                  return ShoppingListsWidget(
                    shoppingLists: state.shoppingLists,
                  );
                } else if (state is ShoppingListError) {
                  return const Center(child: Text('Error'));
                } else if (state is ShoppingListEmpty) {
                  return const Center(
                    child: Text('Empty list. Add items to shopping list'),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return InputDialog(hint: 'Enter shopping list name');
                    });

                BlocProvider.of<ShoppingListBloc>(context).add(AddShoppingList(
                  item: result,
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
