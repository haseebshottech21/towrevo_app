import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container noDataImage(
  BuildContext context,
  String text,
  String image,
) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.height * 0.70,
          child: Image.asset(
            image,
          ),
        ),
      ],
    ),
  );
}
