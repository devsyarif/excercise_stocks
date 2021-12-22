import 'package:flutter/material.dart';

class CustomSnackBar {
  static void snackbar(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
