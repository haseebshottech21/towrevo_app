import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_name_and_desc_screen.dart';
import 'package:towrevo/screens/authentication/signup_user/register_user_screen.dart';
import '/widgets/background_image.dart';
import '/widgets/towrevo_logo.dart';

class RegisterMainScreen extends StatelessWidget {
  static const routeName = '/register-main-screen';
  const RegisterMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final signUpViewModel =Provider.of<RegisterCompanyViewModel>(context);
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              FadeInDown(
                from: 50,
                delay: const Duration(milliseconds: 400),
                child: const TowrevoLogo(),
              ),
              const SizedBox(
                height: 35,
              ),
              FadeInDown(
                from: 15,
                delay: const Duration(milliseconds: 500),
                child: Text(
                  'REGISTER AS',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FadeInDown(
                from: 20,
                delay: const Duration(milliseconds: 550),
                child: Text(
                  'Kindly Select One Option From The Following Before Registering',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF0c355a),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              FadeInUp(
                from: 10,
                delay: const Duration(milliseconds: 500),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      // signUpViewModel.body['type']='1';
                      // print(signUpViewModel.body);
                      Navigator.of(context)
                          .pushNamed(RegistrationNameAndDescScreen.routeName);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color(0xFF083258),
                            Color(0xFF0190ef),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.building,
                                color: Colors.white, size: 80.0),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'REGISTERED BY',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              'COMPANY',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    //   splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      // signUpViewModel.body['type']='2';
                      // print(signUpViewModel.body);
                      Navigator.of(context)
                          .pushNamed(RegisterUserScreen.routeName);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color(0xFF083258),
                            Color(0xFF0190ef),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.user,
                                color: Colors.white, size: 80.0),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'REGISTERED BY',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              'USER',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
