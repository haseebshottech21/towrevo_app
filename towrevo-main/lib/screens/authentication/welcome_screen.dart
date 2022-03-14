import 'package:flutter/material.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';

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
              LoginButton(
                'LOGIN',
                () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SignupButton(
                'SIGN-UP',
                () {
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
