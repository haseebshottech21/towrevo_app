import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/screens/company/company_home_screen.dart';
import 'package:towrevo/screens/users/users_home_screen.dart';
import 'package:towrevo/utilities.dart';
import '/screens/authentication/register_main_screen.dart';
import '/view_model/login_view_model.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/text_form_field.dart';
import '/widgets/background_image.dart';
import '/widgets/towrevo_logo.dart';

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

  validateAndSubmitLoginForm()async{
    if(!_formKey.currentState!.validate()){
      return;
    }else{
      final loginProvider = Provider.of<LoginViewModel>(context,listen: false);
       final bool response =  await loginProvider.loginRequest(
           emailController.text.trim(),
           passwordController.text.trim(),
       );
       if(response){
         final type = await Utilities().getSharedPreferenceValue('type');
           Navigator.of(context).pushNamedAndRemoveUntil(type == '1'?UsersHomeScreen.routeName:CompanyHomeScreen.routeName, (route) => false);
       }
    }
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
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),
                const TowrevoLogo(),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'LOGIN',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                      letterSpacing: 1.8),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Lorem Ipsum is sipmly dummy text of the printing and typesetting',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: const Color(0xFF0c355a),
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFieldForAll(errorGetter: ErrorGetter().emailErrorGetter,hintText: 'Email Address', prefixIcon: const Icon(
                  FontAwesomeIcons.solidEnvelopeOpen,
                  color: Color(0xFF019aff),
                  size: 20.0,
                ),textEditingController: emailController,),
                const SizedBox(
                  height: 10,
                ),
                 Consumer<LoginViewModel>(builder: (ctx,loginViewModel,neverBuildChild){
                   return  TextFormIconWidget(errorGetter: ErrorGetter().passwordErrorGetter,textEditingController: passwordController,obscureText: loginViewModel.obscurePassword, hint: 'Password', prefixIcon: const Icon(FontAwesomeIcons.qrcode,
                       color: Color(0xFF019aff), size: 20.0),onPress: loginViewModel.toggleObscure,);
                 }),

                const SizedBox(
                  height: 10,
                ),
                // Login Button
                FormButtonWidget('LOGIN', () {
                  validateAndSubmitLoginForm();
                }),
                // Login Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Consumer<LoginViewModel>(builder: (ctx,loginViewModel,neverBuildChild){
                          return Checkbox(
                            value: loginViewModel.isRememberChecked,
                            onChanged: (bool? value) {
                              loginViewModel.toggleRemember();
                            },
                          );
                        }),

                        Text('Remember Me',
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 13.0)),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Forgot Password?',
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 13.0),
                            recognizer: null),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    children: [
                      const Icon(FontAwesomeIcons.userEdit,
                          color: Color(0xFF092847), size: 30.0),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'CREATE A NEW ACCOUNT',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'SIGN-UP',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),

                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacementNamed(RegisterMainScreen.routeName);
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
