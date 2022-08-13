import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container userEmptyProfile(BuildContext context) {
  return Container(
    width: 45.w,
    height: 42.h,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      border: Border.all(color: AppColors.primaryColor2, width: 2),
      borderRadius: BorderRadius.circular(50.r),
    ),
    child: ClipOval(
      child: Center(
        child: Icon(
          FontAwesomeIcons.user,
          color: Colors.white,
          size: 23.sp,
        ),
      ),
    ),
  );
}
