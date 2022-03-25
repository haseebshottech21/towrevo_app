import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/web_services/authentication.dart';
import 'package:towrevo/screens/screens.dart';

class SplashViewModel with ChangeNotifier {
  Future<void> navigateToWelcome(BuildContext context) async {
    String type = await Utilities().getSharedPreferenceValue('type') ?? '0';

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

  Future<bool> contactUs(String description) async {
    final loadedData =
        await AuthenticationWebService().contactUsRequest(description);
    if (loadedData != null) {
      return true;
    } else {
      return false;
    }
  }

  String type = '';

  getType() async {
    type = await Utilities().getSharedPreferenceValue('type');
    notifyListeners();
  }
}
