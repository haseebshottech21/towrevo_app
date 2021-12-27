import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_category_and_timing_screen.dart';
import 'package:towrevo/screens/authentication/signup_company/signup_company_widegts/title_widget.dart';
import 'package:towrevo/widgets/back_icon.dart';
import '/view_model/register_company_view_model.dart';
import '/widgets/text_form_field.dart';
import '/widgets/background_image.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';

class RegistrationCredentialScreen extends StatefulWidget {
  const RegistrationCredentialScreen({Key? key}) : super(key: key);

  static const routeName = '/registration-credential';

  @override
  State<RegistrationCredentialScreen> createState() =>
      _RegistrationCredentialScreenState();
}

class _RegistrationCredentialScreenState
    extends State<RegistrationCredentialScreen> {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFromAndSaveData() {
    final _companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _companySignUpProvider.body['email'] =
          emailController.text.trim().toLowerCase();
      _companySignUpProvider.body['phone'] = phoneNumberController.text.trim();
      _companySignUpProvider.body['password'] = passwordController.text.trim();
      _companySignUpProvider.body['password_confirmation'] =
          confirmPasswordController.text.trim();
      print(_companySignUpProvider.body);
      Navigator.of(context)
          .pushNamed(RegistrationCategoryAndTimingScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImage(),
          backIcon(context, () {
            Navigator.pop(context);
          }),
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  FadeInDown(
                    from: 15,
                    delay: const Duration(milliseconds: 500),
                    child: companyTitle(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInDown(
                          from: 20,
                          delay: const Duration(milliseconds: 550),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().emailErrorGetter,
                            hintText: 'Email Address',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.userAlt,
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
                          from: 25,
                          delay: const Duration(milliseconds: 570),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().phoneNumberErrorGetter,
                            hintText: 'Phone',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: phoneNumberController,
                            textInputType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<RegisterCompanyViewModel>(
                          builder:
                              (ctx, registerCompanyViewModel, neverBuildChild) {
                            return FadeInDown(
                              from: 30,
                              delay: const Duration(milliseconds: 590),
                              child: TextFormIconWidget(
                                errorGetter: ErrorGetter().passwordErrorGetter,
                                textEditingController: passwordController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<RegisterCompanyViewModel>(builder:
                            (ctx, registerUserViewModel, neverBuildChild) {
                          return FadeInDown(
                            from: 35,
                            delay: const Duration(milliseconds: 610),
                            child: TextFormIconWidget(
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
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  FadeInDown(
                    from: 35,
                    delay: const Duration(milliseconds: 650),
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StepFormButtonBack(
                            () {
                              Navigator.of(context).pop();
                            },
                            'BACK',
                          ),
                          StepFormButtonNext(
                            () {
                              validateFromAndSaveData();
                            },
                            'NEXT',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
