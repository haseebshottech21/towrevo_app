// import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
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
    getPaymentHistory();
  }

  @override
  void initState() {
    getPaymentHistory();
    super.initState();
  }

  getPaymentHistory() {
    Provider.of<PaymentViewModel>(context, listen: false).paymentHistory();
  }

  @override
  Widget build(BuildContext context) {
    final paymentViewModel =
        Provider.of<PaymentViewModel>(context, listen: true);
    // print(paymentViewModel.dates);

    // print(paymentViewModel.dates['payment_status']);
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
                paymentViewModel.paymentHistoryList.isEmpty
                    ? const SizedBox()
                    : FadeInDown(
                        child: Padding(
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
                                      color: AppColors.primaryColor2
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      letterSpacing: 1.w,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Center(
                                  child: Text(
                                    paymentViewModel.dates['difference']
                                            .toString()
                                            .isEmpty
                                        ? ''
                                        : paymentViewModel.dates['difference']
                                            .toString()
                                            .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      letterSpacing: 1.w,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                if (paymentViewModel.dates['difference']
                                        .toString() !=
                                    'Payment Expire')
                                  payCardHeader(
                                    title: 'LAST PAID',
                                    subTitle: paymentViewModel
                                            .dates['last_payment_date']
                                            .toString()
                                            .isEmpty
                                        ? ''
                                        : paymentViewModel
                                            .dates['last_payment_date']
                                            .toString(),
                                    color: Colors.green,
                                  ),
                                SizedBox(height: 5.h),
                                payCardHeader(
                                  title: 'SUBSCRIPTION EXPIRED',
                                  subTitle: paymentViewModel
                                          .dates['expire_date']
                                          .toString()
                                          .isEmpty
                                      ? ''
                                      : paymentViewModel.dates['expire_date']
                                          .toString(),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                RefreshIndicator(
                  onRefresh: _refresh,
                  child: paymentViewModel.isLoading ||
                          paymentViewModel.paymentHistoryList.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: paymentViewModel.paymentHistoryList.isEmpty
                                ? Center(
                                    child: Text(
                                      '',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 25.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5.w,
                                      ),
                                    ),
                                  )
                                : circularProgress(),
                          ),
                        )
                      : SizedBox(
                          height: ScreenUtil().screenHeight * 0.73,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: FadeInUp(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    paymentViewModel.paymentHistoryList.length,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: ((context, index) => Container(
                                      width: ScreenUtil().screenWidth,
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h, horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
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
                                              Text(
                                                paymentViewModel
                                                    .paymentHistoryList[index]
                                                    .createdAt,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  // fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Icon(
                                          //   CupertinoIcons.arrow_2_circlepath,
                                          //   color: AppColors.primaryColor2,
                                          // ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'AMOUNT',
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  // fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                '\$ ${paymentViewModel.paymentHistoryList[index].amount}',
                                                style: const TextStyle(
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
