import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/screens/authentication/welcome_screen.dart';
import 'package:towrevo/screens/company/company_home_screen.dart';
import 'package:towrevo/screens/onboard/on_board_towrevo.dart';
import 'package:towrevo/screens/users/users_home_screen.dart';
import 'package:towrevo/utilities.dart';

class SplashViewModel {
  Future<void> navigateToWelcome(BuildContext context) async {
    String type = await Utilities().getSharedPreferenceValue('type') ?? '0';
    print(type);

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(seconds: 2),
          child: MyApp.onBoard == '0'
              ? const OnBoardTowrevo()
              : type == '1'
                  ? const UsersHomeScreen()
                  : type == '2'
                      ? const CompanyHomeScreen()
                      : const WelcomeScreen(),
        ),
      );
    });
  }
}
