import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/widgets/background_image.dart';
import 'package:towrevo/widgets/text_form_field.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            const BackgroundImage(),
            // Back Icon
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.arrowLeft,
                    color: Colors.white, size: 20.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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
                      'CHANGE PASSWORD ?',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   'We Will Send Verifaction Code To The Email Address You Registered To Regain Your Password',
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.montserrat(
                    //     color: const Color(0xFF0c355a),
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 14.0,
                    //   ),
                    // ),
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
                      errorGetter: ErrorGetter().passwordErrorGetter,
                      textEditingController: passwordController,
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
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.80,
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
                              'CHANGE PASSWORD',
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
