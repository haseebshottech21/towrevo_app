import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text companyTitle() {
  return Text(
    'COMPANY \nREGISTRATION',
    textAlign: TextAlign.center,
    style: GoogleFonts.montserrat(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 30.0,
      letterSpacing: 2,
    ),
  );
}
