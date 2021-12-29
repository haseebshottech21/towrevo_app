import 'package:flutter/material.dart';

Container profileImageCircle(BuildContext context, String image) {
  return Container(
    width: 55,
    height: 55,
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
    child: ClipOval(
      child: Image.network(
        image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    ),
  );
}
