import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHistoryList extends StatelessWidget {
  final UserHistoryModel userHistoryModel;

  const UserHistoryList({
    required this.userHistoryModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating =
        userHistoryModel.rating == null ? 0 : userHistoryModel.rating!.rate;
    return FadeInUp(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
        // height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userHistoryModel.companyName.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          userHistoryModel.serviceName.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            5,
                            (index) => Icon(
                              rating <= index ? Icons.star_outline : Icons.star,
                              color: Colors.amber,
                              size: 17.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      userHistoryModel.date,
                      style: GoogleFonts.montserrat(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
