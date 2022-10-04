import 'package:flutter/material.dart';

Future<void> showSnackBar({
  required String title,
  required BuildContext context,
  required String labelText,
  required Function onPress,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerState,
  int seconds = 6,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // key: scaffoldMessengerState,
      content: Text(title),
      action: SnackBarAction(
        label: labelText,
        onPressed: () => onPress(),
      ),
      duration: Duration(
        seconds: seconds,
      ),
    ),
  );
}
