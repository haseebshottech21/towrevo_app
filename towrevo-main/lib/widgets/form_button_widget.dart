import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double formButtonHeight = 45;

class FormButtonWidget extends StatelessWidget {
  final String formBtnTxt;
  final VoidCallback onPressed;
  const FormButtonWidget(this.formBtnTxt, this.onPressed, {Key? key})
      : super(key: key);

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
                MediaQuery.of(context).size.width * 0.88, formButtonHeight)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
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
  const StepFormButtonNext(this.onPressed, this.text, {Key? key})
      : super(key: key);

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
          child: Text(
            text,
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

class StepFormButtonBack extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const StepFormButtonBack(this.onPressed, this.text, {Key? key})
      : super(key: key);

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
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
