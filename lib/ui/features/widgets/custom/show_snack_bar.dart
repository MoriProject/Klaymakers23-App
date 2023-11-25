import 'package:flutter/material.dart';

class ShowSnackBar {
  ShowSnackBar._();
  static buildSnackbar(BuildContext context, String message,
      [bool isError = false]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(
          message,
        ),
      ),
    );
  }
}
