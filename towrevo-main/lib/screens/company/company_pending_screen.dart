import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/company/company_notification_utility/company_side_notification_handler.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyPendingScreen extends StatefulWidget {
  const CompanyPendingScreen({Key? key}) : super(key: key);

  @override
  _CompanyPendingScreenState createState() => _CompanyPendingScreenState();
}

class _CompanyPendingScreenState extends State<CompanyPendingScreen> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);

    return Stack(
      children: [
        const FullBackgroundImage(),
        SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              (provider.isLoading || provider.requestServiceList.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: ScreenUtil().screenHeight * 0.65,
                        child: provider.isLoading
                            ? circularProgress()
                            : noDataImage(
                                context,
                                'Waiting Jobs',
                                'assets/images/towing.png',
                              ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.requestServiceList.length,
                      itemBuilder: (context, index) {
                        return FadeInUp(
                          from: 30,
                          child: AcceptDeclineCardItem(
                            serviceRequestModel:
                                provider.requestServiceList[index],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getData() async {
    await Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
        .getRequests(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await Utilities().setUpRequestNotification();
      await CompanySideNotificationHandler().notificationHandler(
        context,
        getData,
      );

      await getData();
      // await CompanySideNotificationHandler()
      //     .notificationHandler(context, getData);
      // await Utilities().setUpRequestNotification();
      // // await checkPayment();
      // await getData();
    });
  }

  // Future<void> checkPayment() async {
  //   Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
  //       .paymentStatusCheck(context);
  // }
}
