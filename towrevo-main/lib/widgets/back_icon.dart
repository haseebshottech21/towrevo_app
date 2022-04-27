import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding backIcon(
  BuildContext context,
  VoidCallback onPressed,
) {
  return Padding(
    padding: EdgeInsets.only(top: 30.h, left: 18.w),
    child: Container(
      height: 30.h,
      width: 35.w,
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: const Color(0xFF092848).withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 14.sp,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
