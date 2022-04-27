import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double formButtonHeight = 45;

class FormButtonWidget extends StatelessWidget {
  final String formBtnTxt;
  final VoidCallback onPressed;
  final bool? signup;

  const FormButtonWidget({
    required this.onPressed,
    required this.formBtnTxt,
    this.signup = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            Color(0xFF0195f7),
            Color(0xFF083054),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          shadowColor: Colors.transparent,
          primary: Colors.transparent,
          minimumSize: Size(
            325.w,
            40.h,
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: signup == true
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  formBtnTxt,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
        ),
      ),
    );
  }
}

class StepFormButtonNext extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? signup;
  const StepFormButtonNext(
      // this.onPressed,
      // this.text,
      {
    required this.onPressed,
    required this.text,
    this.signup = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.7],
          colors: [
            Color(0xFF0195f7),
            Color(0xFF083054),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          shadowColor: Colors.transparent,
          primary: Colors.transparent,
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.30,
            formButtonHeight,
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: signup == true
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  text,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    letterSpacing: 1.0,
                  ),
                ),
        ),
      ),
    );
  }
}

class StepFormButtonBack extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const StepFormButtonBack(
    this.onPressed,
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            shadowColor: Colors.transparent,
            primary: Colors.transparent,
            minimumSize: Size(
                MediaQuery.of(context).size.width * 0.30, formButtonHeight)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
