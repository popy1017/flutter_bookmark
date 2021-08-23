import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool _defaulValidator(String text) => true;

class TextFormDialog extends StatefulWidget {
  TextFormDialog({
    required this.title,
    this.isValid = _defaulValidator,
  });

  final String title;
  final bool Function(String) isValid;

  @override
  _TextFormDialogState createState() => _TextFormDialogState();
}

class _TextFormDialogState extends State<TextFormDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _enableAction = false;

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
        onChanged: (String text) {
          if (widget.isValid(text)) {
            setState(() {
              _enableAction = true;
            });
          } else {
            setState(() {
              _enableAction = false;
            });
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: _enableAction
              ? () {
                  Navigator.pop(context, _textEditingController.text);
                }
              : null,
          child: Text('OK'),
        ),
      ],
    );
  }
}
