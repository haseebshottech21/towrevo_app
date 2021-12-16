import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_otp_screen.dart';
import 'package:towrevo/widgets/background_image.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

class ForgotPasswordOTP extends StatefulWidget {
  const ForgotPasswordOTP({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordOTPState createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> with TickerProviderStateMixin {

    late AnimationController _controller;
  int levelClock = 120;
  bool isTimeAvailable = true;
  String inputOTP = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(seconds: 120), vsync: this);
    _controller.forward().whenComplete(() => isTimeAvailable = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          // Background Image
          const BackgroundImage(),
          // Back Icon
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: Colors.white, size: 20.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              const TowrevoLogo(),
              const SizedBox(
                height: 45,
              ),
              Text(
                'FORGOT PASSWORD \nVERIFICATION',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'We have sent you an email with a code of the number',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        letterSpacing: 0.5),
                  ),
                  Text(
                    'on Your Email',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 55,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Colors.white,
                ),
                outlineBorderRadius: 10,
                style: GoogleFonts.montserrat(
                    color: const Color(0xFF092e52),
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    letterSpacing: 1.0),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  inputOTP = pin;
                  print(inputOTP);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Expiring in',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  // Text(
                  //  '($_controller)',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.montserrat(color: const Color(0xFF0c355a), fontWeight: FontWeight.w700, fontSize: 20.0, letterSpacing: 0.5),
                  // ),
                  Countdown(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_controller),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 35,
              ),
              FormButtonWidget(
                'VERIFY',
                () {
                  // sendOTPRequest(reqFromCompany);
                },
              ),
            ]),
          )
        ],),
      ),
    );
  }
}