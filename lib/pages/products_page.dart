import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_client/blocs/events/products_event.dart';
import 'package:shopping_list_client/blocs/products_bloc.dart';
import 'package:shopping_list_client/blocs/states/products_state.dart';
import 'package:shopping_list_client/data/products_repository.dart';
import 'package:shopping_list_client/pages/args/products_route_arguments.dart';
import 'package:shopping_list_client/widgets/common/input_dialog.dart';
import 'package:shopping_list_client/widgets/products/products_widget.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final ProductsRepository repository;

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductsRouteArguments;

    return BlocProvider(
      create: (context) => ProductsBloc(repository: widget.repository)
        ..add(FetchProducts(shoppingListId: args.shoppingListId)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(args.shoppingListName),
            ),
            body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  return ProductsWidget(
                    products: state.products,
                    shoppingListId: args.shoppingListId,
                  );
                } else if (state is ProductsError) {
                  return const Center(child: Text('Failed to fetch'));
                } else if (state is ProductsListEmpty) {
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
                      return InputDialog(hint: 'Enter product');
                    });

                BlocProvider.of<ProductsBloc>(context).add(AddProduct(
                  item: result,
                  shoppingListId: args.shoppingListId,
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
