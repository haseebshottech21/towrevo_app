import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_category_and_timing_screen.dart';
import '/view_model/register_company_view_model.dart';
import '/widgets/text_form_field.dart';
import '/widgets/background_image.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';

class RegistrationCredentialScreen extends StatefulWidget {
  const RegistrationCredentialScreen({Key? key}) : super(key: key);

  static const routeName = '/registration-credential';

  @override
  State<RegistrationCredentialScreen> createState() => _RegistrationCredentialScreenState();
}

class _RegistrationCredentialScreenState extends State<RegistrationCredentialScreen> {

  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFromAndSaveData(){

    final _companySignUpProvider = Provider.of<RegisterCompanyViewModel>(context,listen: false);
    if(!_formKey.currentState!.validate()){
      return;
    }else{
      _companySignUpProvider.body['email'] = emailController.text.trim();
      _companySignUpProvider.body['phone'] = phoneNumberController.text.trim();
      _companySignUpProvider.body['password'] = passwordController.text.trim();
      _companySignUpProvider.body['password_confirmation'] = confirmPasswordController.text.trim();
      print(_companySignUpProvider.body);
      Navigator.of(context).pushNamed(RegistrationCategoryAndTimingScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImage(),
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
            alignment: Alignment.center,
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'COMPANY \nREGISTRATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        letterSpacing: 2),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:   [
                         TextFieldForAll(errorGetter: ErrorGetter().emailErrorGetter,hintText: 'Email Address',prefixIcon: const Icon(
                          FontAwesomeIcons.userAlt,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),textEditingController: emailController,),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(errorGetter: ErrorGetter().phoneNumberErrorGetter,hintText: 'Phone', prefixIcon: const Icon(
                          FontAwesomeIcons.phoneAlt,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),textEditingController: phoneNumberController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<RegisterCompanyViewModel>(builder: (ctx,registerCompanyViewModel,neverBuildChild){
                          return  TextFormIconWidget(errorGetter: ErrorGetter().passwordErrorGetter,textEditingController: passwordController,obscureText: registerCompanyViewModel.obscurePassword, hint: 'Password', prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                              color: Color(0xFF019aff), size: 20.0),onPress: registerCompanyViewModel.toggleObscure,);
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<RegisterCompanyViewModel>(builder: (ctx,registerUserViewModel,neverBuildChild){
                          return  TextFormIconWidget(confirmPassword: passwordController,errorGetter: ErrorGetter().confirmPasswordErrorGetter,textEditingController: confirmPasswordController,obscureText: registerUserViewModel.obscureConfirmPassword, hint: 'Confirm Password', prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                              color: Color(0xFF019aff), size: 20.0),onPress: registerUserViewModel.toggleObscureConfirm,);
                        }),

                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StepFormButtonBack(() {
                            Navigator.of(context).pop();
                            },
                          'BACK',
                        ),
                        StepFormButtonNext(() {
                        validateFromAndSaveData();
                          },
                          'NEXT',
                        ),
                      ],
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
