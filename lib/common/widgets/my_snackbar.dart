import 'package:flutter/material.dart';

class MySnackbar {
  MySnackbar({
    required this.context,
    required this.message,
    this.snackType = SnackBarType.success,
  });

  final BuildContext context;
  final String message;
  final SnackBarType snackType;

  Color snackbarTheme() {
    if (snackType == SnackBarType.success) {
      return Theme.of(context).colorScheme.background;
    } else {
      return Theme.of(context).colorScheme.error;
    }
  }

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackbarTheme(),
        content: Text(
          message,
        ),
      ),
    );
  }
}

enum SnackBarType { error, success }
