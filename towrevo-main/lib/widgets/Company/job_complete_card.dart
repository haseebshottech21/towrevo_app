import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/screens/company/distance_screen.dart';
import '../../utilities/utilities.dart';
import '../empty_profile.dart';
import '../job_completed_dailogbox.dart';
import '../profile_image_circle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCompleteCard extends StatefulWidget {
  final ServiceRequestModel serviceRequestModel;
  const JobCompleteCard({
    required this.serviceRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  State<JobCompleteCard> createState() => _JobCompleteCardState();
}

class _JobCompleteCardState extends State<JobCompleteCard> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.serviceRequestModel.description.length > 45) {
      firstHalf = widget.serviceRequestModel.description.substring(0, 45);
      secondHalf = widget.serviceRequestModel.description
          .substring(45, widget.serviceRequestModel.description.length);
    } else {
      firstHalf = widget.serviceRequestModel.description;
      secondHalf = "";
    }
  }

  double animHeight = 0.0;
  double animHeightmain = 160.h;
  double heightMain = 200.h;

  double animHeightmainIos = 220.0;
  double heightMainIos = 240.0;
  bool anim = false;

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
                ? heightMain + 12.h
                : widget.serviceRequestModel.description.length > 50
                    ? Platform.isIOS
                        ? heightMain + 20.h
                        : heightMain
                    : animHeightmain,
            width: ScreenUtil().screenWidth * 0.95,
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[2],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            widget.serviceRequestModel.serviceName,
                            style: TextStyle(
                              fontSize: 14.sp,
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
                      height: widget.serviceRequestModel.description.length > 50
                          ? 15.h
                          : 10.h),
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
                                      50) {
                                    Platform.isIOS
                                        ? heightMain = 280.h
                                        : heightMain = 290.h;
                                  }
                                  if (widget.serviceRequestModel.description
                                              .length <
                                          50 &&
                                      widget.serviceRequestModel.destAddress
                                          .isEmpty) {
                                    Platform.isIOS
                                        ? animHeightmain = 150.h
                                        : animHeightmain = 270.h;
                                  }
                                  if (widget.serviceRequestModel.description
                                              .length >
                                          50 &&
                                      widget.serviceRequestModel.destAddress
                                          .isNotEmpty) {
                                    Platform.isIOS
                                        ? heightMain = 350.h
                                        : heightMain = 330.h;
                                  }
                                  if (widget.serviceRequestModel.description
                                              .length <
                                          50 &&
                                      widget.serviceRequestModel.destAddress
                                          .isNotEmpty) animHeightmain = 160.h;
                                  // widget.serviceRequestModel.description
                                  //             .length >
                                  //         50
                                  //     ? Platform.isIOS
                                  //         ? heightMainIos = 370.0
                                  //         : heightMain = 370.0
                                  //     : heightMain = 200.0;
                                  // widget.serviceRequestModel.description
                                  //             .length >
                                  //         50
                                  //     ? widget.serviceRequestModel.destAddress
                                  //             .isEmpty
                                  //         ? Platform.isIOS
                                  //             ? heightMainIos = 370.0
                                  //             : heightMain = 285.0
                                  //         : Platform.isIOS
                                  //             ? heightMainIos = 430.0
                                  //             : heightMain = 345.0
                                  //     : heightMain = 200.0;

                                  widget.serviceRequestModel.destAddress.isEmpty
                                      ? Platform.isIOS
                                          ? animHeight = 350.h
                                          : animHeight = 300.h
                                      : Platform.isIOS
                                          ? animHeight = 230.h
                                          : animHeight = 200.h;
                                  // Platform.isIOS
                                  //     ? animHeightmainIos = animHeightmainIos +
                                  //         (widget.serviceRequestModel
                                  //                 .destAddress.isEmpty
                                  //             ? animHeight / 2.7
                                  //             : animHeight / 1.8)
                                  //     : animHeightmain = animHeightmain +
                                  //         (widget.serviceRequestModel
                                  //                 .destAddress.isEmpty
                                  //             ? animHeight / 2.5
                                  //             : animHeight / 1.5);
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.green[50],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (ctxt) => completeJobDialogbox(
                              ctxt,
                              widget.serviceRequestModel.id,
                              widget.serviceRequestModel.notificationId,
                            ),
                          );
                        },
                        child: const Text(
                          'Job Completed',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
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
              duration: const Duration(microseconds: 400),
              height: widget.serviceRequestModel.destAddress.isEmpty
                  ? animHeight / 2.5.h
                  : animHeight / 1.2.h,
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
                  SizedBox(height: 9.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // padding: EdgeInsets.only(bottom: 0),
                      primary: AppColors.primaryColor2,
                      minimumSize: Size(
                        ScreenUtil().screenWidth * 0.90,
                        35.h,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        DistanceScreen.routeName,
                        arguments: {
                          'origin': LatLng(
                            double.parse(widget.serviceRequestModel.latitude),
                            double.parse(widget.serviceRequestModel.longitude),
                          ),
                          if (widget
                              .serviceRequestModel.destLatitude.isNotEmpty)
                            'destination': LatLng(
                              double.parse(
                                  widget.serviceRequestModel.destLatitude),
                              double.parse(
                                  widget.serviceRequestModel.destLongitude),
                            ),
                        },
                      );
                    },
                    child: Text(
                      'Get Direction',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
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
