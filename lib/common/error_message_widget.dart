import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String error;

  const ErrorMessageWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Text(error),
    );
  }
}
