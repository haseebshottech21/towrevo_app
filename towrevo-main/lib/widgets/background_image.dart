import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}

class FormBackgroundImage extends StatelessWidget {
  const FormBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/formbg.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}

class FullBackgroundImage extends StatelessWidget {
  const FullBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fullbg.jpg'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
