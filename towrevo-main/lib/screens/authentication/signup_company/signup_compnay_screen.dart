import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_otp_screen.dart';
// import 'package:towrevo/screens/authentication/signup_company/registration_otp_screen.dart';
import '../../../error_getter.dart';
import '../../../utilities/towrevo_appcolor.dart';
import '../../../view_model/register_company_view_model.dart';
import '../../../widgets/Company/comapny_signup_title.dart';
import '../../../widgets/back_icon.dart';
import '../../../widgets/background_image.dart';
import '../../../widgets/form_button_widget.dart';
import '../../../widgets/text_form_fields.dart';
import '../../term&condiotion/term_conditon_screen.dart';

class SignupCompanyScreen extends StatefulWidget {
  const SignupCompanyScreen({Key? key}) : super(key: key);

  static const routeName = '/signup_company';

  @override
  State<SignupCompanyScreen> createState() => _SignupCompanyScreenState();
}

class _SignupCompanyScreenState extends State<SignupCompanyScreen> {
  final companyNameController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyPasswordController = TextEditingController();
  final companyConfirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void validateFromAndSignupCompany() async {
    final _companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } 
    // else if (_companySignUpProvider.body['image'].toString().isEmpty) {
    //   Fluttertoast.showToast(msg: 'Please Enter Image');
    //   return;
    // } 
    else {
      _companySignUpProvider.body['first_name'] = companyNameController.text;
      _companySignUpProvider.body['email'] =
          companyEmailController.text.trim().toLowerCase();
      _companySignUpProvider.body['phone'] = companyPhoneController.text.trim();
      _companySignUpProvider.body['password'] =
          companyPasswordController.text.trim();
      _companySignUpProvider.body['password_confirmation'] =
          companyConfirmPasswordController.text.trim();

      // print(_companySignUpProvider.body);
      bool response = await _companySignUpProvider.registerCompany(context);
      // print('response: $response');
      if (response) {
        Navigator.of(context).pushNamed(
          RegistrationOTPScreen.routeName,
          arguments: true,
        );
      }
    }
  }

  @override
  void initState() {
    final provider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    provider.initalize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel =
        Provider.of<RegisterCompanyViewModel>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          // backIcon(context, () {
          //   Navigator.pop(context);
          // }),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backIcon(context, () {
                  Navigator.pop(context);
                }),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 5.h),
                        FadeInDown(
                          from: 15,
                          delay: const Duration(milliseconds: 500),
                          child: const CompanySignUpTitle(),
                        ),
                        SizedBox(height: 20.h),
                        Consumer<RegisterCompanyViewModel>(
                          builder: (ctx, imagePicker, neverBuildChild) {
                            return FadeInDown(
                              from: 20,
                              delay: const Duration(milliseconds: 600),
                              child: GestureDetector(
                                onTap: () {
                                  imagePicker.pickImage();
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 105.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF09365f),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: imagePicker.body['image'] == ''
                                          ? Icon(
                                              FontAwesomeIcons.building,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              size: 75.sp,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.r),
                                              ),
                                              child: Image.file(
                                                File(imagePicker.imagePath),
                                                fit: BoxFit.fill,
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
                                          color: const Color(0xFF019aff),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Icon(FontAwesomeIcons.camera,
                                            color: Colors.white, size: 18.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        FadeInDown(
                          from: 25,
                          delay: const Duration(milliseconds: 650),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().companyNameErrorGetter,
                            hintText: 'Company Name',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.userAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: companyNameController,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 30,
                          delay: const Duration(milliseconds: 550),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().emailErrorGetter,
                            hintText: 'Email Address',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidEnvelopeOpen,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: companyEmailController,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 35,
                          delay: const Duration(milliseconds: 570),
                          child: PhoneField(
                            errorGetter: ErrorGetter().phoneNumberErrorGetter,
                            hintText: 'Phone Number',
                            textEditingController: companyPhoneController,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Consumer<RegisterCompanyViewModel>(
                          builder:
                              (ctx, registerCompanyViewModel, neverBuildChild) {
                            return FadeInDown(
                              from: 40,
                              delay: const Duration(milliseconds: 590),
                              child: TextFormIconWidget(
                                errorGetter: ErrorGetter().passwordErrorGetter,
                                textEditingController:
                                    companyPasswordController,
                                obscureText:
                                    registerCompanyViewModel.obscurePassword,
                                hint: 'Password',
                                prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                                    color: Color(0xFF019aff), size: 20.0),
                                onPress: registerCompanyViewModel.toggleObscure,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        Consumer<RegisterCompanyViewModel>(
                          builder:
                              (ctx, registerUserViewModel, neverBuildChild) {
                            return FadeInDown(
                              from: 45,
                              delay: const Duration(milliseconds: 610),
                              child: TextFormIconWidget(
                                confirmPassword: companyPasswordController,
                                errorGetter:
                                    ErrorGetter().confirmPasswordErrorGetter,
                                textEditingController:
                                    companyConfirmPasswordController,
                                obscureText: registerUserViewModel
                                    .obscureConfirmPassword,
                                hint: 'Confirm Password',
                                prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                                    color: Color(0xFF019aff), size: 20.0),
                                onPress:
                                    registerUserViewModel.toggleObscureConfirm,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 50,
                          delay: const Duration(milliseconds: 620),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: const Color(0xFF092848),
                                value: registerViewModel
                                    .isCheckedTermsAndCondition,
                                onChanged: (bool? value) {
                                  registerViewModel.toggleTermsAndCondition();
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
                                  SizedBox(width: 3.w),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'Term & Condition and Privacy Policay',
                                          style: GoogleFonts.montserrat(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () =>
                                                Navigator.of(context).pushNamed(
                                                  TermAndCondition.routeName,
                                                  arguments: true,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 40,
                          delay: const Duration(milliseconds: 650),
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // StepFormButtonBack(
                                //   () {
                                //     Navigator.of(context).pop();
                                //   },
                                //   'BACK',
                                // ),
                                StepFormButtonNext(
                                  onPressed: registerViewModel.isLoading
                                      ? null
                                      : () {
                                          validateFromAndSignupCompany();
                                          // validate(registerViewModel);
                                        },
                                  // onPressed: validateFromAndSignupCompany,
                                  text: 'SIGNUP',
                                  signup: registerViewModel.isLoading
                                      ? true
                                      : false,
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     validateFromAndSignupCompany();
                                //   },
                                //   child: Text('Sign Up'),
                                // )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
