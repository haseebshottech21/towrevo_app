import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Padding backIcon(
  BuildContext context,
  VoidCallback onPressed,
) {
  return Padding(
    // padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
    padding: const EdgeInsets.only(top: 30, left: 20),

    child: Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.095,
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: const Color(0xFF092848).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 15.0,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
