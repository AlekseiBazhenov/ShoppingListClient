import 'package:flutter/widgets.dart';
import 'package:shopping_list_client/models/product.dart';
import 'package:shopping_list_client/widgets/common/labeled_checkbox.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    Key? key,
    required this.item,
    required this.onStateChanged,
  }) : super(key: key);

  final Product item;
  final ValueChanged<bool> onStateChanged;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.item.bought;
  }

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: Text(
        widget.item.name,
        style: TextStyle(
          fontSize: 20,
          decoration:
              _isSelected ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
          widget.onStateChanged(newValue);
        });
      },
    );
  }
}
