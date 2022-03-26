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
  double animHeightmain = 200.0;
  double heightMain = 220.0;

  double animHeightmainIos = 230.0;
  double heightMainIos = 240.0;
  bool anim = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            height: widget.serviceRequestModel.description.length > 50
                ? Platform.isIOS
                    ? widget.serviceRequestModel.description.length > 80
                        ? heightMainIos + 15
                        : heightMainIos
                    : heightMain
                : Platform.isIOS
                    ? animHeightmainIos
                    : animHeightmain,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[2],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
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
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.serviceRequestModel.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            (widget.serviceRequestModel.destAddress.isEmpty
                                        ? widget.serviceRequestModel.distance
                                        : widget
                                            .serviceRequestModel.totalDistance)
                                    .toStringAsFixed(2) +
                                (widget.serviceRequestModel.destAddress.isEmpty
                                    ? ' miles away'
                                    : ' total distance'),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[1],
                          color: AppColors.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            widget.serviceRequestModel.serviceName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Issue',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 2),
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
                                        flag ? "show more" : "show less",
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: const StadiumBorder(),
                          primary: Colors.blue[50],
                        ),
                        onPressed: anim == true
                            ? null
                            : () {
                                setState(() {
                                  // widget.serviceRequestModel.description
                                  //             .length >
                                  //         50
                                  //     ? Platform.isIOS
                                  //         ? heightMainIos = 370.0
                                  //         : heightMain = 370.0
                                  //     : heightMain = 200.0;
                                  widget.serviceRequestModel.description
                                              .length >
                                          50
                                      ? widget.serviceRequestModel.destAddress
                                              .isEmpty
                                          ? Platform.isIOS
                                              ? heightMainIos = 370.0
                                              : heightMain = 285.0
                                          : Platform.isIOS
                                              ? heightMainIos = 430.0
                                              : heightMain = 345.0
                                      : heightMain = 200.0;

                                  widget.serviceRequestModel.destAddress.isEmpty
                                      ? Platform.isIOS
                                          ? animHeight = 320
                                          : animHeight = 300
                                      : Platform.isIOS
                                          ? animHeight = 250
                                          : animHeight = 200;
                                  Platform.isIOS
                                      ? animHeightmainIos = animHeightmainIos +
                                          (widget.serviceRequestModel
                                                  .destAddress.isEmpty
                                              ? animHeight / 2.5
                                              : animHeight / 1.6)
                                      : animHeightmain = animHeightmain +
                                          (widget.serviceRequestModel
                                                  .destAddress.isEmpty
                                              ? animHeight / 2.8
                                              : animHeight / 1.3);
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              duration: const Duration(microseconds: 400),
              height: widget.serviceRequestModel.destAddress.isEmpty
                  ? animHeight / 2.5
                  : animHeight / 1.2,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                color: const Color(0xFFF5F5F5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.location_pin,
                        size: 12,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Pick Location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      widget.serviceRequestModel.address,
                      style: const TextStyle(
                        fontSize: 14,
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
                      children: const [
                        Icon(
                          Icons.location_pin,
                          size: 12,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Drop Location',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    const SizedBox(height: 2),
                  if (widget.serviceRequestModel.destAddress.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        widget.serviceRequestModel.destAddress,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // padding: EdgeInsets.only(bottom: 0),
                      primary: AppColors.primaryColor2,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.90,
                        40,
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
                    child: const Text(
                      'Get Direction',
                      style: TextStyle(
                        color: Colors.white,
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
