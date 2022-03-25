import 'package:flutter/material.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';

import '../../models/service_request_model.dart';
import '../../utilities/utilities.dart';
import '../empty_profile.dart';
import '../profile_image_circle.dart';

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

  double animHeight = 0.0;
  double animHeightmain = 200.0;
  bool anim = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            height: animHeightmain,
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
                      fontSize: 12,
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
                  const SizedBox(height: 20),
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
                                  widget.serviceRequestModel.destAddress.isEmpty
                                      ? animHeight = 150
                                      : animHeight = 180;
                                  animHeightmain = animHeightmain +
                                      (widget.serviceRequestModel.destAddress
                                              .isEmpty
                                          ? animHeight / 2
                                          : animHeight);
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
                          const SizedBox(width: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              duration: const Duration(microseconds: 400),
              height: widget.serviceRequestModel.destAddress.isEmpty
                  ? animHeight / 2
                  : animHeight,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
