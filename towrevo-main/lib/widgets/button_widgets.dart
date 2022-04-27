import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  final String? btnText;
  final VoidCallback? onPressed;
  const LoginButton(this.btnText, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40.h,
          width: 280.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF0195f7),
                  Color(0xFF083054),
                ],
              )),
          child: Center(
              child: Text(
            '$btnText',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.0.sp,
              letterSpacing: 1.0,
            ),
          )),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  final String? btnText;
  final VoidCallback? onPressed;
  const SignupButton(
    this.btnText,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.060,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Center(
              child: Text(
            '$btnText',
            style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                letterSpacing: 1.0),
          )),
        ),
      ),
    );
  }
}
