import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  validateAndChangePassword(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);

      provider.changePassword(
          passwordController.text.trim(), confirmPassword.text.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: SingleChildScrollView(
        child: Stack(
          children: [
           
            const FullBackgroundImage(),
           
            Align(
              alignment: Alignment.topLeft,
              child: backIcon(context, () {
                Navigator.of(context).pop();
              }),
            ),
           
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const TowrevoLogo(),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      'CREATE NEW PASSWORD',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your new password must be different from previous password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormIconWidget(
                      errorGetter: ErrorGetter().passwordErrorGetter,
                      textEditingController: passwordController,
                      obscureText: true,
                      hint: 'Password',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.qrcode,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      onPress: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormIconWidget(
                      errorGetter: ErrorGetter().confirmPasswordErrorGetter,
                      confirmPassword: passwordController,
                      textEditingController: confirmPassword,
                      obscureText: true,
                      hint: 'Confirm Password',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.qrcode,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      onPress: () {},
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          validateAndChangePassword(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.065,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF0195f7),
                                Color(0xFF083054),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'RESET PASSWORD',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
