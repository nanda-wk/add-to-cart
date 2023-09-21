import 'package:flutter/material.dart';

class MessageBoxUtil {
  String? titleText;
  Color? color;

  MessageBoxUtil({
    this.titleText,
    this.color = Colors.blueGrey,
  });

  void showSnackBarMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(titleText ?? "Title"),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        elevation: 20,
      ),
    );
  }
}
