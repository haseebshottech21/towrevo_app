import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/screens/term&condiotion/term_conditon_screen.dart';
import 'package:towrevo/utilities/state_city_utility.dart';
import '../../../utilities/towrevo_appcolor.dart';
import '/screens/authentication/signup_company/registration_otp_screen.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);
  static const routeName = 'register-user';

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  validateForm() async {
    final registerUserViewModel =
        Provider.of<RegisterUserViewModel>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      return;
    }
    //  else if (registerUserViewModel.image.isEmpty ||
    //     registerUserViewModel.extension.isEmpty) {
    //   Fluttertoast.showToast(msg: 'Image must not be Empty');
    //   print('image is empty');
    //   return;
    // }
    else if (!registerUserViewModel.isCheckedTermsAndCondition) {
      Fluttertoast.showToast(msg: 'Please Accept Term&Conditon');
      return;
    } else if (registerUserViewModel.selectedState == null ||
        registerUserViewModel.selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please Select State And City');
      return;
    } else {
      bool response = await registerUserViewModel.userSignUp({
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'type': '1',
        'email': emailController.text.trim().toLowerCase(),
        'phone': phoneNumberController.text.trim(),
        'password': passwordController.text.trim(),
        'password_confirmation': confirmPasswordController.text.trim(),
        'notification_id': MyApp.notifyToken,
        'state': registerUserViewModel.selectedState!,
        'city': registerUserViewModel.selectedCity!,
        if (registerUserViewModel.image.isNotEmpty &&
            registerUserViewModel.extension.isNotEmpty)
          'extension': registerUserViewModel.extension,
        if (registerUserViewModel.image.isNotEmpty &&
            registerUserViewModel.extension.isNotEmpty)
          'image': registerUserViewModel.image,
      }, context);
      if (response) {
        Navigator.of(context)
            .pushNamed(RegistrationOTPScreen.routeName, arguments: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FullBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backIcon(context, () {
                  Navigator.pop(context);
                }),
                FadeInDown(
                  from: 15,
                  delay: const Duration(milliseconds: 500),
                  child: Center(
                    child: Text(
                      'USER \nREGISTRATION',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 26.sp,
                        letterSpacing: 1.5.w,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        FadeInDown(
                          from: 30,
                          delay: const Duration(milliseconds: 550),
                          child: Consumer<RegisterUserViewModel>(
                            builder: (ctx, imagePicker, neverBuildChild) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      imagePicker.pickImage();
                                    },
                                    child: Container(
                                      width: 120.w,
                                      height: 105.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF09365f),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: imagePicker.imagePath.isEmpty
                                          ? Icon(
                                              FontAwesomeIcons.user,
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              size: 75.sp,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.r),
                                              ),
                                              child: Image.file(
                                                File(imagePicker.imagePath),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 85.w,
                                    top: 75.h,
                                    child: Container(
                                      width: 35.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF019aff)
                                            .withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.white,
                                        size: 17.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 18.h),
                        FadeInDown(
                          from: 40,
                          delay: const Duration(milliseconds: 600),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().firstNameErrorGetter,
                            hintText: 'First Name',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.userAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: firstNameController,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 45,
                          delay: const Duration(milliseconds: 620),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().lastNameErrorGetter,
                            hintText: 'Last Name',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.userAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: lastNameController,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 50,
                          delay: const Duration(milliseconds: 640),
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
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 55,
                          delay: const Duration(milliseconds: 660),
                          child: PhoneField(
                            errorGetter: ErrorGetter().phoneNumberErrorGetter,
                            hintText: 'Phone Number',
                            textEditingController: phoneNumberController,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 60,
                          delay: const Duration(milliseconds: 680),
                          child: Consumer<RegisterUserViewModel>(builder:
                              (ctx, registerUserViewModel, neverBuildChild) {
                            return TextFormIconWidget(
                              errorGetter: ErrorGetter().passwordErrorGetter,
                              textEditingController: passwordController,
                              obscureText:
                                  registerUserViewModel.obscurePassword,
                              hint: 'Password',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.qrcode,
                                color: Color(0xFF019aff),
                                size: 20.0,
                              ),
                              onPress: registerUserViewModel.toggleObscure,
                            );
                          }),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 65,
                          delay: const Duration(milliseconds: 700),
                          child: Consumer<RegisterUserViewModel>(builder:
                              (ctx, registerUserViewModel, neverBuildChild) {
                            return TextFormIconWidget(
                              confirmPassword: passwordController,
                              errorGetter:
                                  ErrorGetter().confirmPasswordErrorGetter,
                              textEditingController: confirmPasswordController,
                              obscureText:
                                  registerUserViewModel.obscureConfirmPassword,
                              hint: 'Confirm Password',
                              prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                                  color: Color(0xFF019aff), size: 20.0),
                              onPress:
                                  registerUserViewModel.toggleObscureConfirm,
                            );
                          }),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 70,
                          delay: const Duration(milliseconds: 700),
                          child: Consumer<RegisterUserViewModel>(
                            builder:
                                (ctx, registerUserViewModel, neverBuildChild) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black45),
                                ),
                                width: double.infinity,
                                child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select State',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: registerUserViewModel.selectedState,
                                    onChanged: (val) => registerUserViewModel
                                        .changeState(val.toString()),
                                    items: usCityState.entries.map((state) {
                                      return DropdownMenuItem(
                                        child: Text(state.key),
                                        value: state.key,
                                      );
                                    }).toList()),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 70,
                          delay: const Duration(milliseconds: 700),
                          child: Consumer<RegisterUserViewModel>(
                            builder:
                                (ctx, registerUserViewModel, neverBuildChild) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black45),
                                ),
                                width: double.infinity,
                                child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select City',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: registerUserViewModel.selectedCity,
                                    onChanged: (val) => registerUserViewModel
                                        .changeCity(val.toString()),
                                    items: (registerUserViewModel
                                                    .selectedState ==
                                                null
                                            ? []
                                            : usCityState[registerUserViewModel
                                                .selectedState] as List<String>)
                                        .map((state) {
                                      return DropdownMenuItem(
                                        child: Text(state),
                                        value: state,
                                      );
                                    }).toList()),
                              );
                            },
                          ),
                        ),
                        FadeInDown(
                          from: 75,
                          delay: const Duration(milliseconds: 720),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Consumer<RegisterUserViewModel>(
                                    builder: (ctx, userRegisterViewModel,
                                        neverBuildChild) {
                                      return Checkbox(
                                        activeColor: const Color(0xFF092848),
                                        value: userRegisterViewModel
                                            .isCheckedTermsAndCondition,
                                        onChanged: (bool? value) {
                                          userRegisterViewModel
                                              .toggleTermsAndCondition();
                                        },
                                      );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'I Accept',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    'Term & Condition and Privacy Policay',
                                                style: GoogleFonts.montserrat(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11.sp,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                            TermAndCondition
                                                                .routeName,
                                                            arguments: true,
                                                          )
                                                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                // builder: (BuildContext context) => const RegisterAsScreen())),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        FadeInDown(
                          from: 80,
                          delay: const Duration(milliseconds: 750),
                          child: FormButtonWidget(
                            formBtnTxt: 'SIGNUP',
                            onPressed: () {
                              validateForm();
                              // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Consumer<RegisterUserViewModel>(
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
    );
  }

  @override
  void initState() {
    final provider = Provider.of<RegisterUserViewModel>(context, listen: false);
    provider.initializeValues();
    super.initState();
  }
}
