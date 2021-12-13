import 'package:flutter/material.dart';

Padding circularProgress() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Center(
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 12,
            ), //show this if state is loading
            Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
