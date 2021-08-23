import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFormDialog extends StatefulWidget {
  TextFormDialog({
    required this.title,
  });

  final String title;

  @override
  _TextFormDialogState createState() => _TextFormDialogState();
}

class _TextFormDialogState extends State<TextFormDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText: 'URL',
          hintText: 'https://www.example.com',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, _textEditingController.text);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
