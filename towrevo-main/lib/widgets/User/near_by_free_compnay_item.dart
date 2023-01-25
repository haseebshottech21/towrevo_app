import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/company_model.dart';
// import '../../screens/user/user_monthly_payment_screen.dart';
import '../../utilities/towrevo_appcolor.dart';
import '../../utilities/utilities.dart';
import '../../view_model/user_home_screen_view_model.dart';
import '../profile_image_circle.dart';

class NearByFreeCompanyItem extends StatelessWidget {
  final CompanyModel companyModel;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  const NearByFreeCompanyItem({
    Key? key,
    required this.companyModel,
    this.scaffoldMessengerKey,
  }) : super(key: key);

  sendRequest(
    String companyId,
    BuildContext context,
    String notificationId,
    String phoneNumber,
    String email,
  ) async {
    // if (email.isNotEmpty) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    provider.getRequestCount(context, 0);

    provider.requestToCompany(
      context,
      provider.body['longitude']!,
      provider.body['latitude']!,
      provider.body['address']!,
      provider.body['dest_longitude']!,
      provider.body['dest_latitude']!,
      provider.body['dest_address']!,
      provider.body['description']!,
      provider.body['service']!,
      companyId,
      notificationId,
      scaffoldMessengerKey!,
    );
    // } else {
    //   Navigator.of(context).pushNamed(
    //     UserMonthlyPaymentScreen.routeName,
    //     arguments: (phoneNumber.isEmpty && email.isEmpty)
    //         ? 404
    //         : email.isEmpty
    //             ? 401
    //             : 0,
    //   );
    // }
  }

  openDialPad(
    String phoneNumber,
    String email,
    BuildContext context,
  ) {
    // if (email.isNotEmpty) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);

    provider.getRequestCount(context, 1);
    launch("tel://+1$phoneNumber");
    // } else {
    //   Navigator.of(context).pushNamed(
    //     UserMonthlyPaymentScreen.routeName,
    //     arguments: (phoneNumber.isEmpty && email.isEmpty)
    //         ? 404
    //         : email.isEmpty
    //             ? 401
    //             : 0,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // print('Email: ${companyModel.email}');
    // print('Phone Number: ${companyModel.phoneNumber}');

    return FadeInUp(
      from: 50,
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        margin: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 8.h,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 12.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            companyModel.from +
                                (companyModel.to.isEmpty
                                    ? ''
                                    : ' - ' + companyModel.to) +
                                ' ( ${companyModel.distance} )',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(width: 5.w),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  companyModel.email.isEmpty
                                      ? 'Request Company'
                                      : companyModel.firstName,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 4.w),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: 16.sp,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              companyModel.avgRating,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  companyModel.image.isNotEmpty
                      ? companyModel.email.isEmpty
                          ? Container(
                              height: 44.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: ClipOval(
                                child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaY: 3,
                                      sigmaX: 3,
                                    ), //SigmaX and Y are just for X and Y directions
                                    child: Image.network(
                                      Utilities.imageBaseUrl +
                                          companyModel.image,
                                      fit: BoxFit.cover,
                                    ) //here you can use any widget you'd like to blur .
                                    ),
                              ),
                            )
                          : profileImageCircle(
                              context,
                              Utilities.imageBaseUrl + companyModel.image,
                            )
                      : const Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.home_work_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'STARTING AT ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 2.h),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[50],
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child:
                  Text(
                    '\$${companyModel.startingPrice}',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor2,
                    ),
                  ),
                  // ),
                ],
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(companyModel.description),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[700],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SizedBox(
                        width: 75.w,
                        // color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // companyModel.email.isEmpty ||
                            //         companyModel.distance.contains('ft')
                            //     ? const SizedBox()
                            //     :
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: companyModel.isCompanyAvailable
                                  ? () {
                                      sendRequest(
                                        companyModel.userId,
                                        context,
                                        companyModel.notificationId,
                                        companyModel.phoneNumber,
                                        companyModel.email,
                                      );
                                    }
                                  : null,
                              icon: FaIcon(
                                FontAwesomeIcons.paperPlane,
                                color: companyModel.isCompanyAvailable
                                    ? primaryColor
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ),
                            // companyModel.email.isEmpty
                            //     ? const SizedBox()
                            //     :
                            SizedBox(width: 18.w),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: companyModel.isCompanyAvailable
                                  ? () {
                                      openDialPad(
                                        companyModel.phoneNumber,
                                        companyModel.email,
                                        context,
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.phone_in_talk,
                                color: companyModel.isCompanyAvailable
                                    ? primaryColor
                                    : Colors.grey,
                                size: 22.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
