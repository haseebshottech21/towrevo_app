import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:towrevo/screens/authentication/welcome_screen.dart';
class SplashViewModel {

  Future<void> navigateToWelcome(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 2),
            child: const WelcomeScreen(),
          ),
        );
      }
    );
  }
}
