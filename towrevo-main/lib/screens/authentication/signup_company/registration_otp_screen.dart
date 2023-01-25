import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationOTPScreen extends StatefulWidget {
  const RegistrationOTPScreen({Key? key}) : super(key: key);
  static const routeName = '/otp';

  @override
  State<RegistrationOTPScreen> createState() => _RegistrationOTPScreenState();
}

class _RegistrationOTPScreenState extends State<RegistrationOTPScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int levelClock = 600;
  bool isTimeAvailable = true;
  String inputOTP = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(seconds: 600), vsync: this);
    _controller.forward().whenComplete(() => isTimeAvailable = false);
  }

  void sendOTPRequest(bool requestFromCompany) async {
    if (isTimeAvailable) {
      if (inputOTP.length == 5) {
        final provider = Provider.of<OTPViewModel>(context, listen: false);

        bool response = await provider.validateOTP(
          provider.resendUniqueId,
          inputOTP,
          context,
        );

        if (!requestFromCompany && response) {
          //user entry
          Navigator.of(context).pushNamedAndRemoveUntil(
            UsersHomeScreen.routeName,
            (route) => false,
          );
        } else if (requestFromCompany && response) {
          //company entry
          Navigator.of(context).pushNamedAndRemoveUntil(
            CompanyHomeScreen.routeName,
            (route) => false,
          );
        } else if (!response) {
          if (provider.otpExpire == true) {
            isTimeAvailable = false;
            // _controller.stop();
            _controller.reset();
          }
          // _controller.repeat();
        }
      } else {
        Fluttertoast.showToast(msg: 'Please Fill Required Length');
      }
    } else {
      Fluttertoast.showToast(msg: 'OTP is Expired, Please Resend it');
    }
  }

  void resendOTPRequest() async {
    final provider = Provider.of<OTPViewModel>(context, listen: false);
    final response = await provider.resendOTP(provider.resendUniqueId);
    if (response == true) {
      _controller.reset();
      _controller.repeat();
    }

    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool reqFromCompany = ModalRoute.of(context)!.settings.arguments as bool;
    final otpViewModel = Provider.of<OTPViewModel>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to leave OTP screen?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background Image
              const BackgroundImage(),
              // Back Icon
              // backIcon(context, () {
              //   Navigator.pop(context);
              // }),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 30.h,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    const TowrevoLogo(),
                    SizedBox(height: 35.h),
                    Text(
                      'OTP \nVERIFICATION',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32.sp,
                        letterSpacing: 1.w,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      children: [
                        Text(
                          'We have sent you an email with a code of the number',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0c355a),
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            letterSpacing: 0.2.w,
                          ),
                        ),
                        Text(
                          'on Your Email',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0c355a),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            letterSpacing: 0.5.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    OTPTextField(
                      length: 5,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 55,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.white,
                      ),
                      outlineBorderRadius: 10.r,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF092e52),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        letterSpacing: 1.0.w,
                      ),
                      onChanged: (pin) {
                        // print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        inputOTP = pin;
                        // print(inputOTP);
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Expiring in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0c355a),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            letterSpacing: 0.5.w,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Countdown(
                          animation: StepTween(
                            begin: levelClock, // THIS IS A USER ENTERED NUMBER
                            end: 0,
                          ).animate(_controller),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't received the OTP ?",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0c355a),
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'RESEND OTP',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF0c355a),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    resendOTPRequest();
                                  },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35.h),
                    FormButtonWidget(
                      formBtnTxt: 'VERIFY',
                      onPressed: otpViewModel.isLoading
                          ? null
                          : () {
                              // print(reqFromCompany);
                              sendOTPRequest(reqFromCompany);
                            },
                      isLoading: otpViewModel.isLoading ? true : false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()} : ${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      '( $timerText )',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        color: const Color(0xFF0c355a),
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
        letterSpacing: 0.5.w,
      ),
    );
  }
}
