import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/utitlites/towrevo_appcolor.dart';
import 'package:towrevo/screens/company/distance_screen.dart';

class JobCompleteCard extends StatefulWidget {
  final String userName;
  final double userDistance;
  final String serviceType;
  final String pickLocation;
  final String dropLocation;
  final String reqOriginLatitude;
  final String reqOriginLongitude;
  final String reqDestLatitude;
  final String reqDestLongitude;
  final String probText;
  final Widget profileImage;
  final void Function()? completeOnPressed;
  const JobCompleteCard({
    required this.userName,
    required this.userDistance,
    required this.serviceType,
    required this.dropLocation,
    required this.pickLocation,
    required this.reqOriginLatitude,
    required this.reqOriginLongitude,
    required this.reqDestLatitude,
    required this.reqDestLongitude,
    required this.probText,
    required this.profileImage,
    required this.completeOnPressed,
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

    if (widget.probText.length > 45) {
      firstHalf = widget.probText.substring(0, 45);
      secondHalf = widget.probText.substring(45, widget.probText.length);
    } else {
      firstHalf = widget.probText;
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
                      widget.profileImage,
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.userDistance.toStringAsFixed(2) +
                                (widget.dropLocation.isEmpty
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
                          // border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            widget.serviceType,
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
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        // style: ElevatedButton.styleFrom(
                        //   // padding: EdgeInsets.zero,
                        //   shape: const StadiumBorder(),
                        //   primary: Colors.blueGrey.shade100,
                        //   side: const BorderSide(color: Colors.blueGrey),
                        // ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: const StadiumBorder(),
                          primary: Colors.blue[50],
                        ),
                        onPressed: anim == true
                            ? null
                            : () {
                                setState(() {
                                  widget.dropLocation.isEmpty
                                      ? animHeight = 300
                                      : animHeight = 200;
                                  animHeightmain = animHeightmain +
                                      (widget.dropLocation.isEmpty
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
                      ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12),
                        //   shape: const StadiumBorder(),
                        //   primary: Colors.blue[50],
                        // ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          // padding: EdgeInsets.s,
                          primary: Colors.green[50],
                        ),
                        onPressed: widget.completeOnPressed,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              duration: const Duration(microseconds: 400),
              height: widget.dropLocation.isEmpty ? animHeight / 2 : animHeight,
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
                      widget.pickLocation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (widget.dropLocation.isNotEmpty) const Divider(),
                  if (widget.dropLocation.isNotEmpty)
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
                  if (widget.dropLocation.isNotEmpty) const SizedBox(height: 2),
                  if (widget.dropLocation.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        widget.dropLocation,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   shape: const StadiumBorder(),
                    //   primary: Colors.blue[50],
                    // ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // padding: EdgeInsets.s,
                      primary: AppColors.primaryColor2,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.90,
                        40,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        DistanceScreen.routeName,
                        // arguments: {
                        //   'Origin': LatLng(
                        //     double.parse(widget.reqOriginLatitude),
                        //     double.parse(widget.reqOriginLongitude),
                        //   ),
                        //   'Destination': LatLng(
                        //     double.parse(widget.reqDestLatitude),
                        //     double.parse(widget.reqDestLongitude),
                        //   ),
                        // },
                        arguments: LatLng(
                          double.parse(widget.reqOriginLatitude),
                          double.parse(widget.reqOriginLongitude),
                        ),
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
