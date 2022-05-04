import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Future _refresh() async {
    // print('refreshing...');
  }

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
                  padding: EdgeInsets.only(
                    // left: 5.w,
                    // right: 5.w,
                    top: 10.h,
                    bottom: 1.h,
                  ),
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    // height: 70.h,
                    color: AppColors.primaryColor,
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    // decoration: BoxDecoration(
                    //   color: AppColors.primaryColor,
                    //   borderRadius: BorderRadius.circular(5.r),
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'MONTHLY SUBSCRIPTION',
                            style: TextStyle(
                              color: AppColors.primaryColor2.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Center(
                          child: Text(
                            '30 DAYS REMAINING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        payCardHeader(
                          title: 'LAST PAID',
                          subTitle: '04-APRIL-2022',
                          color: Colors.green,
                        ),
                        SizedBox(height: 5.h),
                        payCardHeader(
                          title: 'SUBSCRIPTION EXPIED',
                          subTitle: '05-MAY-2022',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refresh,
                  child: SizedBox(
                    height: ScreenUtil().screenHeight * 0.73,
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
                                  vertical: 12.h, horizontal: 5.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DATE',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      const Text(
                                        '04-April-2022',
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    CupertinoIcons.arrow_2_circlepath,
                                    color: AppColors.primaryColor2,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'AMOUNT',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      const Text(
                                        '\$ 50.00',
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row payCardHeader({
    required String title,
    required String subTitle,
    Color? color = Colors.white,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
