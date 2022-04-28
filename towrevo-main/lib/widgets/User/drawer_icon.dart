import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container drawerIcon(
  BuildContext context,
  VoidCallback onPressed,
) {
  return Container(
    height: 50.h,
    width: ScreenUtil().screenWidth * 0.10,
    padding: const EdgeInsets.all(0.5),
    decoration: BoxDecoration(
      color: const Color(0xFF092848).withOpacity(0.5),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      icon: FaIcon(
        FontAwesomeIcons.bars,
        color: Colors.white,
        size: 15.sp,
      ),
      onPressed: onPressed,
    ),
  );
}

Padding drawerIconSecond(
  BuildContext context,
  VoidCallback onPressed,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 40, bottom: 0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.10,
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: const Color(0xFF092848).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const FaIcon(
          FontAwesomeIcons.bars,
          color: Colors.white,
          size: 15.0,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
