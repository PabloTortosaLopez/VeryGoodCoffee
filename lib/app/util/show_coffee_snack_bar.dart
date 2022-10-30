import 'package:flutter/material.dart';

Future<void> showCoffeeSnakcBar({
  required BuildContext context,
  required Color backgroundColor,
  required String title,
  required Function() onFinished,
}) async {
  final snackBar = SnackBar(
    content: Text(title),
    backgroundColor: backgroundColor,
  );
  await ScaffoldMessenger.of(context)
      .showSnackBar(snackBar)
      .closed
      .then((_) => onFinished());
}
