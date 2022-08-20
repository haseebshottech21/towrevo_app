import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  const ForgotPasswordOTPScreen({Key? key}) : super(key: key);
  static const routeName = 'forget-password-otp';

  @override
  _ForgotPasswordOTPScreenState createState() =>
      _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  int levelClock = 120;
  bool isTimeAvailable = true;
  String inputOTP = '';
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(seconds: 120), vsync: this);
    _controller.forward().whenComplete(() => isTimeAvailable = false);
  }

  validateAndSendOTP(BuildContext context) {
    if (!isTimeAvailable) {
      Fluttertoast.showToast(msg: 'OTP has been Expired, Please Try Again.');
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (inputOTP.length == 5) {
      final loginProvider = Provider.of<LoginViewModel>(context, listen: false);
      if (loginProvider.token.isNotEmpty) {
        loginProvider.sendOTP(inputOTP, loginProvider.token,
            password.text.trim(), confirmPassword.text.trim(), context);
      }
    } else {
      Fluttertoast.showToast(msg: ' Please Fill Require Length');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            const FormBackgroundImage(),
            // Back Icon
            backIcon(context, () {
              Navigator.pop(context);
            }),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 30.h,
                ),
                child: Column(children: [
                  SizedBox(height: 5.h),
                  const TowrevoLogo(),
                  SizedBox(height: 15.h),
                  Text(
                    'FORGOT PASSWORD \nVERIFICATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.sp,
                      letterSpacing: 1,
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
                          letterSpacing: 0.5.w,
                        ),
                      ),
                      Text(
                        'on this Email : \n$email',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF0c355a),
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: OTPTextField(
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
                        fontSize: 18.sp,
                        letterSpacing: 1.w,
                      ),
                      onChanged: (pin) {
                        // print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        inputOTP = pin;
                        // print(inputOTP);
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
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
                  SizedBox(height: 15.h),
                  Consumer<RegisterUserViewModel>(
                    builder: (ctx, registerUserViewModel, neverBuildChild) {
                      return TextFormIconWidget(
                        errorGetter: ErrorGetter().passwordErrorGetter,
                        textEditingController: password,
                        obscureText: registerUserViewModel.obscurePassword,
                        hint: 'Password',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.qrcode,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        onPress: registerUserViewModel.toggleObscure,
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  Consumer<RegisterUserViewModel>(
                      builder: (ctx, registerUserViewModel, neverBuildChild) {
                    return TextFormIconWidget(
                      confirmPassword: confirmPassword,
                      errorGetter: ErrorGetter().confirmPasswordErrorGetter,
                      textEditingController: confirmPassword,
                      obscureText: registerUserViewModel.obscureConfirmPassword,
                      hint: 'Confirm Password',
                      prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                          color: Color(0xFF019aff), size: 20.0),
                      onPress: registerUserViewModel.toggleObscureConfirm,
                    );
                  }),
                  SizedBox(height: 20.h),
                  FormButtonWidget(
                    formBtnTxt: 'VERIFY',
                    onPressed: () {
                      validateAndSendOTP(context);
                    },
                  ),
                ]),
              ),
            ),
            Consumer<LoginViewModel>(
              builder: (ctx, loginViewMode, neverUpdate) {
                return loginViewMode.isLoading
                    ? SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: circularProgress())
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
