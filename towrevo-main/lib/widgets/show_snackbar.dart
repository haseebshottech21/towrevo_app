import 'package:flutter/material.dart';

Future<void> showSnackBar({
  required String title,
  required BuildContext context,
  required String labelText,
  required Function onPress,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: labelText,
        onPressed: () => onPress(),
      ),
    ),
  );
}
