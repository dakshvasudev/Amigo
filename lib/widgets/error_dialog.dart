import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog({Key? key, required this.message}) : super(key: key);
  String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kColorRed),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: Text('OK'),
          ),
        ),
      ],
    );
  }
}
