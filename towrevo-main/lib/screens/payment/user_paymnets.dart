import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPaymnets extends StatefulWidget {
  const UserPaymnets({Key? key}) : super(key: key);
  static const routeName = '/user-payments';

  @override
  State<UserPaymnets> createState() => _UserPaymnetsState();
}

class _UserPaymnetsState extends State<UserPaymnets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: backIcon(context, () {
                        Navigator.of(context).pop();
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h, left: 45.w),
                      child: Text(
                        'MY PAYMENTS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.sp,
                          letterSpacing: 1.w,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Last Paid: 04-April-2022',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Payment Expire in 25 Days',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().screenHeight * 0.75,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 25,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: ((context, index) => Container(
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.only(bottom: 2.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '04-April-2022',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '\$50',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
                // SizedBox(width: 50.w),
                // FadeInUp(
                //   from: 40,
                //   duration: const Duration(milliseconds: 500),
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 5.w,
                //       vertical: 10.h,
                //     ),
                //     width: ScreenUtil().screenWidth,
                //     height: ScreenUtil().screenHeight * 0.90,
                //     child: Column(
                //       children: [
                //         (provider.isLoading || provider.userHistoryList.isEmpty)
                //             ? Align(
                //                 alignment: Alignment.center,
                //                 child: SizedBox(
                //                   height: ScreenUtil().screenHeight * 0.65,
                //                   child: provider.isLoading
                //                       ? circularProgress()
                //                       : noDataImage(
                //                           context,
                //                           'NO COMPANY HISTORY',
                //                           'assets/images/towing.png',
                //                         ),
                //                 ),
                //               )
                //             : Expanded(
                //                 child: ListView.builder(
                //                   padding: EdgeInsets.zero,
                //                   shrinkWrap: true,
                //                   itemCount: provider.userHistoryList.length,
                //                   itemBuilder: (ctx, index) {
                //                     return UserHistoryList(
                //                       userHistoryModel:
                //                           provider.userHistoryList[index],
                //                     );
                //                   },
                //                 ),
                //               ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
