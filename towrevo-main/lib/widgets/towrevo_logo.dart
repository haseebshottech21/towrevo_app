import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TowrevoLogo extends StatelessWidget {
  const TowrevoLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 110.h,
        width: ScreenUtil().screenWidth * 0.45,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class TowrevoLogoSmall extends StatelessWidget {
  const TowrevoLogoSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75.h,
        width: ScreenUtil().screenWidth * 0.35,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class TowrevoLogoExtraSmall extends StatelessWidget {
  const TowrevoLogoExtraSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 85.h,
        width: ScreenUtil().screenWidth * 0.35,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
