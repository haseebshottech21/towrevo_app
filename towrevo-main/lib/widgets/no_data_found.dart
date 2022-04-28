import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container noDataImage(
  BuildContext context,
  String text,
  String image,
) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.height * 0.70,
          child: Image.asset(
            image,
          ),
        ),
      ],
    ),
  );
}
