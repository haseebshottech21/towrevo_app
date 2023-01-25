import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHistoryTow extends StatefulWidget {
  const UserHistoryTow({Key? key}) : super(key: key);
  static const routeName = '/user-history';

  @override
  _UserHistoryTowState createState() => _UserHistoryTowState();
}

class _UserHistoryTowState extends State<UserHistoryTow> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        Provider.of<UserHomeScreenViewModel>(context, listen: false)
            .getUserHistory(context);
        getPaymentHistory();
      },
    );
    super.initState();
  }

  getPaymentHistory() {
    Provider.of<PaymentViewModel>(context, listen: false).checkPaymentExpire();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserHomeScreenViewModel>(
      context,
      listen: true,
    );

    final paymentViewModel = Provider.of<PaymentViewModel>(
      context,
      listen: true,
    );

    // print(provider.userPaymet);

    // final int? statusCode = ModalRoute.of(context)!.settings.arguments as int;

    // print(paymentViewModel.paymentExpired);

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
                        'MY HISTORY',
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
                // SizedBox(width: 50.w),
                FadeInUp(
                  from: 40,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 10.h,
                    ),
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight * 0.90,
                    child: Column(
                      children: [
                        (provider.isLoading || provider.userHistoryList.isEmpty)
                            ? Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: ScreenUtil().screenHeight * 0.65,
                                  child: provider.isLoading
                                      ? circularProgress()
                                      : noDataImage(
                                          context,
                                          'NO COMPANY HISTORY',
                                          'assets/images/towing.png',
                                        ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: provider.userHistoryList.length,
                                  itemBuilder: (ctx, index) {
                                    return UserHistoryList(
                                      userHistoryModel:
                                          provider.userHistoryList[index],
                                      paymentExpired:
                                          paymentViewModel.paymentExpired,
                                    );
                                  },
                                ),
                              ),
                      ],
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
}
