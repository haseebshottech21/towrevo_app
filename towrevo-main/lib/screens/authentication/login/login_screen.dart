import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  validateAndSubmitLoginForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final loginProvider = Provider.of<LoginViewModel>(context, listen: false);
      final bool response = await loginProvider.loginRequest(
        emailController.text.trim().toLowerCase(),
        passwordController.text.trim(),
      );
      if (response) {
        final type = await Utilities().getSharedPreferenceValue('type');
        Navigator.of(context).pushNamedAndRemoveUntil(
            type == '1'
                ? UsersHomeScreen.routeName
                : CompanyHomeScreen.routeName,
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundImage(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 18.0.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    FadeInDown(
                      from: 40,
                      delay: const Duration(milliseconds: 400),
                      child: const TowrevoLogo(),
                    ),
                    SizedBox(height: 30.h),
                    FadeInDown(
                      from: 20,
                      delay: const Duration(milliseconds: 500),
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0.sp,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FadeInDown(
                      from: 30,
                      delay: const Duration(milliseconds: 600),
                      child: TextFieldForAll(
                        errorGetter: ErrorGetter().emailErrorGetter,
                        hintText: 'Email Address',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidEnvelopeOpen,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        textEditingController: emailController,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Consumer<LoginViewModel>(
                      builder: (ctx, loginViewModel, neverBuildChild) {
                        return FadeInDown(
                          from: 35,
                          delay: const Duration(milliseconds: 650),
                          child: TextFormIconWidget(
                            errorGetter: ErrorGetter().passwordErrorGetter,
                            textEditingController: passwordController,
                            obscureText: loginViewModel.obscurePassword,
                            hint: 'Password',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.qrcode,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            onPress: loginViewModel.toggleObscure,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    // Login Button
                    FadeInDown(
                      from: 45,
                      delay: const Duration(milliseconds: 750),
                      child: FormButtonWidget(
                        formBtnTxt: 'LOGIN',
                        onPressed: () {
                          // print('LOGIN');
                          validateAndSubmitLoginForm();
                        },
                      ),
                    ),
                    // Login Button
                    FadeInDown(
                      from: 25,
                      delay: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Consumer<LoginViewModel>(
                                  builder:
                                      (ctx, loginViewModel, neverBuildChild) {
                                    return Checkbox(
                                      activeColor: const Color(0xFF092848),
                                      value: loginViewModel.isRememberChecked,
                                      onChanged: (bool? value) {
                                        loginViewModel.toggleRemember();
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'Remember Me',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.routeName);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Forgot Password ?',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12.0.sp,
                                      ),
                                      recognizer: null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    FadeInUp(
                      from: 50,
                      delay: const Duration(milliseconds: 700),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.userEdit,
                              color: const Color(0xFF092847),
                              size: 30.0.sp,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'CREATE A NEW ACCOUNT',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0.sp,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'SIGN-UP',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                          RegisterMainScreen.routeName,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<LoginViewModel>(
              builder: (ctx, loginViewMode, neverUpdate) {
                return loginViewMode.isLoading
                    ? SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: circularProgress(),
                      )
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        final utilities = Utilities();
        emailController.text =
            await utilities.getSharedPreferenceValue('remember_email') ?? '';
        passwordController.text =
            await utilities.getSharedPreferenceValue('remember_password') ?? '';
      },
    );
    super.initState();
  }
}
