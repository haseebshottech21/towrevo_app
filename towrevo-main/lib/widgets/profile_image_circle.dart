import 'package:flutter/material.dart';
import '../utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container profileImageCircle(BuildContext context, String image) {
  return Container(
    width: ScreenUtil().screenWidth * 0.12,
    height: 40.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(50.r),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container profileImageSquare(BuildContext context, String image) {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      boxShadow: kElevationToShadow[2],
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}
