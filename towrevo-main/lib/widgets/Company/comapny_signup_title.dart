import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CompanySignUpTitle extends StatelessWidget {
  const CompanySignUpTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
