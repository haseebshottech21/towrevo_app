import 'package:flutter/material.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';

AlertDialog completeJobDialogbox(
    BuildContext context, String id, String notificationId) {
  return AlertDialog(
    backgroundColor: const Color(0xFF092848),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Are You Sure Job is Completed ?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('NO'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await CompanyHomeScreenViewModel().acceptDeclineOrDone(
                    '3', id, context,
                    notificationId: notificationId);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('YES'),
            ),
          ],
        )
      ],
    ),
  );
}
