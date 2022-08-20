import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
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
              SizedBox(height: 15.h),
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
