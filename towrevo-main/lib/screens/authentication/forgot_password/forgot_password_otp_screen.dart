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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const TowrevoLogo(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'FORGOT PASSWORD \nVERIFICATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 28.0,
                      letterSpacing: 1,
                    ),
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
                        'on this Email : $email',
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
                  const SizedBox(
                    height: 20,
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
                      // print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      inputOTP = pin;
                      // print(inputOTP);
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
                  Consumer<RegisterUserViewModel>(
                      builder: (ctx, registerUserViewModel, neverBuildChild) {
                    return TextFormIconWidget(
                      errorGetter: ErrorGetter().passwordErrorGetter,
                      textEditingController: password,
                      obscureText: registerUserViewModel.obscurePassword,
                      hint: 'Password',
                      prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                          color: Color(0xFF019aff), size: 20.0),
                      onPress: registerUserViewModel.toggleObscure,
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 25,
                  ),
                  FormButtonWidget(
                    'VERIFY',
                    () {
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
                        height: MediaQuery.of(context).size.height,
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
