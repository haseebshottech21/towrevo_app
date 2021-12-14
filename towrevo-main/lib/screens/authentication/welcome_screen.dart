import 'package:flutter/material.dart';
import 'package:towrevo/screens/authentication/register_main_screen.dart';
import '/screens/authentication/login/login_screen.dart';

import '/widgets/background_image.dart';
import '/widgets/button_widgets.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginButton('LOGIN', (){
               Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              },
              ),
              const SizedBox(
                height: 15,
              ),
              SignupButton('SIGN-UP', (){
                Navigator.of(context).pushNamed(RegisterMainScreen.routeName);
              },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
