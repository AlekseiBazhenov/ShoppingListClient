import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputDialog extends StatelessWidget {

  final String hint;

  InputDialog({required this.hint,});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    return AlertDialog(
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            var text = _textFieldController.text;
            Navigator.pop(context, text);
          },
        ),
      ],
    );
  }
}
