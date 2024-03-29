import 'dart:io';
import 'package:flutter/material.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/widgets/Loaders/glow_circle.dart';

Future openBottomSheet(BuildContext context, String companyName) {
  return showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    // barrierColor: Colors.greenAccent,
    //background color for modal bottom screen
    backgroundColor: Colors.white,
    //elevates modal bottom screen
    elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        height: Platform.isIOS
            ? MediaQuery.of(context).size.height * 0.20
            : MediaQuery.of(context).size.height * 0.22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                const GlowCircle(
                  glowHeight: 8,
                  glowWidth: 8,
                  glowbegin: 0,
                  glowend: 10,
                  miliseconds: 600,
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName.isEmpty ? 'Company Name' : companyName,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Towing On The Way'),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Accepted',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Please Wait...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
