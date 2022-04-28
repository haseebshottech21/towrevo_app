import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromToLocation extends StatelessWidget {
  final String fromLocationText;
  final String toLocationText;
  final Function() fromOnTap;
  final Function() toOnTap;

  const FromToLocation({
    required this.fromLocationText,
    required this.toLocationText,
    required this.fromOnTap,
    required this.toOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 2.w),
        Column(
          children: [
            SizedBox(height: 4.h),
            Icon(
              Icons.my_location,
              size: 22.sp,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              height: 5.h,
              width: 5.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 5.h,
              width: 5.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 5.h,
              width: 5.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 8.h),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 22.sp,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(width: 6.h),
        Container(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            left: 10.w,
            right: 15.w,
          ),
          width: ScreenUtil().screenWidth * 0.76,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: kElevationToShadow[4],
          ),
          child: Column(
            children: [
              locationBox(
                context: context,
                title: 'Where From?',
                location: fromLocationText,
                onTap: fromOnTap,
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ScreenUtil().screenWidth * 0.62,
                    child: Divider(
                      thickness: 0.5,
                      height: 5.h,
                      color: Colors.black54,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.retweet,
                    size: 15.sp,
                    color: AppColors.primaryColor2,
                  )
                ],
              ),
              SizedBox(height: 4.h),
              locationBox(
                context: context,
                title: 'Where To?',
                location: toLocationText,
                onTap: toOnTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget locationBox({
    required BuildContext context,
    required String title,
    required String location,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryColor2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    location,
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
