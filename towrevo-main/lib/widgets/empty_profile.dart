import 'package:flutter/material.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyProfile extends StatelessWidget {
  const EmptyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 40.h,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[2],
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.person,
        size: 25.sp,
        color: Colors.white,
      ),
    );
  }
}
