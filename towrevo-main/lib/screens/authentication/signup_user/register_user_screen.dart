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
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/screens/term&condiotion/term&conditon_screen.dart';
import 'package:towrevo/widgets/back_icon.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import '/screens/authentication/signup_company/registration_otp_screen.dart';
import '/view_model/register_user_view_model.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/text_form_field.dart';

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
                        fontSize: 30.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
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
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF09365f),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: imagePicker.imagePath.isEmpty
                                        ? Icon(
                                            FontAwesomeIcons.user,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            size: 75.0,
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Image.file(
                                              File(imagePicker.imagePath),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  left: 85,
                                  top: 85,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF019aff),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Icon(FontAwesomeIcons.camera,
                                        color: Colors.white, size: 18.0),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(
                          height: 10,
                        ),
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
                        const SizedBox(
                          height: 10,
                        ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInDown(
                          from: 55,
                          delay: const Duration(milliseconds: 660),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().phoneNumberErrorGetter,
                            hintText: 'Phone Number',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: phoneNumberController,
                            textInputType: TextInputType.phone,
                            prefixPhone: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                              prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                                  color: Color(0xFF019aff), size: 20.0),
                              onPress: registerUserViewModel.toggleObscure,
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                        FadeInDown(
                          from: 70,
                          delay: const Duration(milliseconds: 720),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Consumer<RegisterUserViewModel>(builder: (ctx,
                                      userRegisterViewModel, neverBuildChild) {
                                    return Checkbox(
                                      activeColor: const Color(0xFF092848),
                                      value: userRegisterViewModel
                                          .isCheckedTermsAndCondition,
                                      onChanged: (bool? value) {
                                        userRegisterViewModel
                                            .toggleTermsAndCondition();
                                      },
                                    );
                                  }),
                                  Row(
                                    children: [
                                      Text(
                                        'I Accept',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    'Term & Condition and Privacy Policay',
                                                style: GoogleFonts.montserrat(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
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
                          from: 75,
                          delay: const Duration(milliseconds: 750),
                          child: FormButtonWidget(
                            'SIGNUP',
                            () {
                              validateForm();
                              // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          // Back Icon
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
