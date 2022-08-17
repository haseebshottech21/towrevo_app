import 'dart:io';
import 'package:flutter/material.dart';
import 'package:towrevo/screens/company/company_notification_utility/company_side_notification_handler.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import '../../models/service_request_model.dart';
import '../../utilities/utilities.dart';
import '../empty_profile.dart';
import '../profile_image_circle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptDeclineCardItem extends StatefulWidget {
  final bool isExpanded;

  final ServiceRequestModel serviceRequestModel;

  const AcceptDeclineCardItem({
    required this.serviceRequestModel,
    this.isExpanded = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AcceptDeclineCardItem> createState() => _AcceptDeclineCardItemState();
}

class _AcceptDeclineCardItemState extends State<AcceptDeclineCardItem> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  // CompanySideNotificationHandler notificationHandler =
  //     CompanySideNotificationHandler();

  @override
  void initState() {
    super.initState();

    if (widget.serviceRequestModel.description.length > 50) {
      firstHalf = widget.serviceRequestModel.description.substring(0, 50);
      secondHalf = widget.serviceRequestModel.description
          .substring(50, widget.serviceRequestModel.description.length);
    } else {
      firstHalf = widget.serviceRequestModel.description;
      secondHalf = "";
    }
  }

  // final compnayNotifiction = CompanySideNotificationHandler();

  double animHeight = 0.0;
  double animHeightmain = 160.h;
  double heightMain = 200.h;
  double heightMain80 = 220.h;

  double animHeightmainIos = 220.0.h;
  double heightMainIos = 240.0.h;
  bool anim = false;

  // @override
  // void dispose() {
  //   CompanySideNotificationHandler().audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            // height: widget.serviceRequestModel.description.length > 50
            //     ? Platform.isIOS
            //         ? widget.serviceRequestModel.description.length > 80
            //             ? heightMainIos + 10
            //             : heightMainIos
            //         : heightMain
            //     : Platform.isIOS
            //         ? animHeightmainIos
            //         : animHeightmain,
            height: widget.serviceRequestModel.description.length > 80
                ? heightMain + 15.h
                : widget.serviceRequestModel.description.length > 50
                    ? heightMain
                    : animHeightmain,
            width: ScreenUtil().screenWidth * 0.95,
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[2],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      widget.serviceRequestModel.image.isNotEmpty
                          ? profileImageSquare(
                              context,
                              Utilities.imageBaseUrl +
                                  widget.serviceRequestModel.image,
                            )
                          : const EmptyProfile(),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.serviceRequestModel.name,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            (widget.serviceRequestModel.destAddress.isEmpty
                                        ? widget.serviceRequestModel.distance
                                        : widget
                                            .serviceRequestModel.totalDistance)
                                    .toStringAsFixed(2) +
                                (widget.serviceRequestModel.destAddress.isEmpty
                                    ? ' miles away'
                                    : ' miles total distance'),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[1],
                          color: AppColors.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: Text(
                            widget.serviceRequestModel.serviceName,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Issue',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: secondHalf!.isEmpty
                          ? Text(firstHalf!)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flag
                                      ? (firstHalf! + '....')
                                      : (firstHalf! + secondHalf!),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        flag ? "\nshow more" : "\nshow less",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: widget.serviceRequestModel.description.length > 80
                        ? 22.h
                        : widget.serviceRequestModel.description.length > 50
                            ? 18.h
                            : 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shape: const StadiumBorder(),
                          primary: Colors.blue[50],
                        ),
                        onPressed: anim == true
                            ? null
                            : () {
                                setState(() {
                                  if (widget.serviceRequestModel.description
                                          .length >
                                      50) heightMain = 260.h;
                                  if (widget.serviceRequestModel.description
                                          .length <
                                      50) animHeightmain = 160.h;
                                  if (widget.serviceRequestModel.description
                                              .length >
                                          50 &&
                                      widget.serviceRequestModel.destAddress
                                          .isNotEmpty) heightMain = 285.h;
                                  if (widget.serviceRequestModel.description
                                              .length <
                                          50 &&
                                      widget.serviceRequestModel.destAddress
                                          .isNotEmpty) animHeightmain = 150.h;
                                  // ? widget.serviceRequestModel.destAddress
                                  //         .isEmpty
                                  //     ? Platform.isIOS
                                  //         ? heightMainIos = 320.h
                                  //         : heightMain = 285.h
                                  //     : Platform.isIOS
                                  //         ? heightMainIos = 370.h
                                  //         : heightMain = 345.h
                                  // : heightMain = 180.h;

                                  widget.serviceRequestModel.destAddress.isEmpty
                                      ? Platform.isIOS
                                          ? animHeight = 160.h
                                          : animHeight = 150.h
                                      : Platform.isIOS
                                          ? animHeight = 220.h
                                          : animHeight = 180.h;
                                  Platform.isIOS
                                      ? animHeightmainIos = animHeightmainIos +
                                          (widget.serviceRequestModel
                                                  .destAddress.isEmpty
                                              ? animHeight / 2.7
                                              : animHeight / 1.8)
                                      : animHeightmain = animHeightmain +
                                          (widget.serviceRequestModel
                                                  .destAddress.isEmpty
                                              ? animHeight / 2.5
                                              : animHeight / 1.6);
                                  anim = true;
                                });
                              },
                        child: Text(
                          'View Location',
                          style: TextStyle(
                            color: anim == true
                                ? Colors.grey
                                : Colors.blue.shade700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.red[50],
                            ),
                            onPressed: () async {
                              // setState(() {
                              //   CompanySideNotificationHandler().stopSound();
                              // });

                              await CompanyHomeScreenViewModel()
                                  .acceptDeclineOrDone(
                                '2',
                                widget.serviceRequestModel.id,
                                context,
                                notificationId:
                                    widget.serviceRequestModel.notificationId,
                              );
                            },
                            child: const Text(
                              'Decline',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.green[50],
                            ),
                            onPressed: () async {
                              await CompanyHomeScreenViewModel()
                                  .acceptDeclineOrDone(
                                '1',
                                widget.serviceRequestModel.id,
                                context,
                                notificationId:
                                    widget.serviceRequestModel.notificationId,
                              );
                            },
                            child: const Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              duration: const Duration(microseconds: 200),
              height: widget.serviceRequestModel.destAddress.isEmpty
                  ? animHeight / 2.5
                  : animHeight / 1.8,
              width: ScreenUtil().screenWidth * 0.95,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 11.sp,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Pick Location',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text(
                      widget.serviceRequestModel.address,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    const Divider(),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 11.sp,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Drop Location',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    SizedBox(height: 2.h),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        widget.serviceRequestModel.destAddress,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
