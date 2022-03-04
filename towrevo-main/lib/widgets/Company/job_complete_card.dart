import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/screens/company/distance_screen.dart';



class JobCompleteCard extends StatefulWidget {
  final String userName;
  final String userDistance;
  final String serviceType;
  final String pickLocation;
  final String dropLocation;
  final String reqOriginLatitude;
  final String reqOriginLongitude;
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
                            '${widget.userDistance} miles away',
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
                                      : animHeight = 180;
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
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 10),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(
    //       vertical: 15,
    //       horizontal: 15,
    //     ),
    //     width: MediaQuery.of(context).size.width,
    //     // height: 50,
    //     decoration: BoxDecoration(
    //       boxShadow: kElevationToShadow[6],
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             Container(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 widget.userName,
    //                 style: const TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(width: 5),
    //             Container(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 '(${widget.userDistance} mi)',
    //                 style: const TextStyle(
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ),
    //             // provider.requestServiceList[index].image.isNotEmpty
    //             //     ? profileImageCircle(
    //             //         context,
    //             //         Utilities.imageBaseUrl +
    //             //             provider.requestServiceList[index].image,
    //             //       )
    //             //     :
    //             const Spacer(),
    //             // const CircleAvatar(
    //             //   backgroundColor: Colors.black,
    //             //   child: Icon(
    //             //     Icons.home_work_outlined,
    //             //     color: Colors.white,
    //             //   ),
    //             // ),
    //             widget.profileImage,
    //           ],
    //         ),
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 5,
    //             ),
    //             decoration: BoxDecoration(
    //               color: AppColors.primaryColor2.withOpacity(0.9),
    //               borderRadius: BorderRadius.circular(20),
    //               border: Border.all(color: AppColors.primaryColor, width: 1.5),
    //             ),
    //             child: Text(
    //               widget.serviceType,
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         // timelineRow(pickLocation),
    //         // timelineLastRow(dropLocation),
    //         viewLocationRow(
    //           widget.pickLocation,
    //           widget.dropLocation,
    //           context,
    //         ),
    //         const SizedBox(height: 10),
    //         Align(
    //           alignment: Alignment.centerLeft,
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(horizontal: 5),
    //             child: secondHalf!.isEmpty
    //                 ? Text(firstHalf!)
    //                 : Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         flag
    //                             ? (firstHalf! + '....')
    //                             : (firstHalf! + secondHalf!),
    //                         style: const TextStyle(
    //                           color: Colors.black87,
    //                         ),
    //                       ),
    //                       InkWell(
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: <Widget>[
    //                             Text(
    //                               flag ? "show more" : "show less",
    //                               style: const TextStyle(color: Colors.blue),
    //                             ),
    //                           ],
    //                         ),
    //                         onTap: () {
    //                           setState(() {
    //                             flag = !flag;
    //                           });
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //           ),
    //         ),
    //         // Align(
    //         //   alignment: Alignment.centerLeft,
    //         //   child: Container(
    //         //     padding: const EdgeInsets.symmetric(horizontal: 5),
    //         //     child: Column(
    //         //       crossAxisAlignment: CrossAxisAlignment.start,
    //         //       children: [
    //         //         const Text(
    //         //           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution...',
    //         //           textAlign: TextAlign.start,
    //         //         ),
    //         //         Row(
    //         //           mainAxisAlignment: MainAxisAlignment.end,
    //         //           children: [
    //         //             InkWell(
    //         //               onTap: () {
    //         //                 // setState(() {
    //         //                 //   textExpand = !textExpand;
    //         //                 // });
    //         //               },
    //         //               child: const Text(
    //         //                 // textExpand == false ? "show more" : "show less",
    //         //                 'show less',
    //         //                 style: TextStyle(color: Colors.blue),
    //         //               ),
    //         //             ),
    //         //           ],
    //         //         ),
    //         //       ],
    //         //     ),
    //         //   ),
    //         // ),
    //         const SizedBox(height: 5),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 // padding: const EdgeInsets.symmetric(horizontal: 12),
    //                 shape: const StadiumBorder(),
    //                 primary: Colors.blue[50],
    //               ),
    //               onPressed: () {
    //                 // Navigator.of(context).pushNamed(
    //                 //   MapDistanceScreen.routeName,
    //                 //   arguments: LatLng(
    //                 //     double.parse(provider
    //                 //         .requestServiceList[index].latitude),
    //                 //     double.parse(
    //                 //       provider
    //                 //           .requestServiceList[index].longitude,
    //                 //     ),
    //                 //   ),
    //                 // );
    //               },
    //               child: const Text(
    //                 'Get Directions',
    //                 style: TextStyle(
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //             ),
    //             Image.asset(
    //               "assets/images/spinner.gif",
    //               height: 30.0,
    //               width: 30.0,
    //             ),
    //             ElevatedButton(
    //               // style: ElevatedButton.styleFrom(
    //               //   padding: const EdgeInsets.symmetric(horizontal: 12),
    //               //   shape: const StadiumBorder(),
    //               //   primary: Colors.blue[50],
    //               // ),
    //               style: ElevatedButton.styleFrom(
    //                 shape: const StadiumBorder(),
    //                 // padding: EdgeInsets.s,
    //                 primary: Colors.green[50],
    //               ),
    //               onPressed: widget.completeOnPressed,
    //               child: const Text(
    //                 'Job Completed',
    //                 style: TextStyle(
    //                   color: Colors.green,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

  // Widget timelineRow(String title) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: <Widget>[
  //       Expanded(
  //         flex: 1,
  //         child: Column(
  //           // mainAxisAlignment: MainAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               Icons.location_pin,
  //               color: AppColors.primaryColor2,
  //               size: 30,
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               width: 5,
  //               height: 5,
  //               decoration: BoxDecoration(
  //                 color: AppColors.primaryColor2,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               width: 5,
  //               height: 5,
  //               decoration: BoxDecoration(
  //                 color: AppColors.primaryColor2,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               width: 5,
  //               height: 5,
  //               decoration: BoxDecoration(
  //                 color: AppColors.primaryColor2,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             // const SizedBox(height: 5),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         flex: 9,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             // Text(
  //             //   point,
  //             //   style: const TextStyle(
  //             //     fontFamily: "regular",
  //             //     fontSize: 11,
  //             //     fontWeight: FontWeight.w500,
  //             //     color: Colors.black87,
  //             //   ),
  //             // ),
  //             const SizedBox(height: 5),
  //             Text(
  //               title + '\n',
  //               style: const TextStyle(
  //                 fontFamily: "regular",
  //                 fontSize: 14,
  //                 color: Colors.black54,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

//   Widget timelineLastRow(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Expanded(
//           flex: 1,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Icon(
//                 Icons.location_pin,
//                 color: AppColors.primaryColor2,
//                 size: 30,
//               ),
//               // Container(
//               //   width: 3,
//               //   height: 20,
//               //   decoration: const BoxDecoration(
//               //     color: Colors.transparent,
//               //     shape: BoxShape.rectangle,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 9,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Text(
//               //   point,
//               //   style: const TextStyle(
//               //     fontFamily: "regular",
//               //     fontSize: 11,
//               //     fontWeight: FontWeight.w500,
//               //     color: Colors.black87,
//               //   ),
//               // ),
//               const SizedBox(height: 5),
//               Text(
//                 title + '\n',
//                 style: const TextStyle(
//                   fontFamily: "regular",
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget viewLocationRow(
//       String picklocation, String droplocation, BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           // crossAxisAlignment: CrossAxisAlignment.stretch,
//           // mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Icon(
//               Icons.my_location,
//               size: 25,
//               color: AppColors.primaryColor2,
//             ),
//             const SizedBox(height: 8),
//             Container(
//               height: 5,
//               width: 5,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor2,
//                 shape: BoxShape.circle,
//               ),
//               // child: const Text(""),
//             ),
//             const SizedBox(height: 8),
//             // Container(
//             //   height: 5,
//             //   width: 5,
//             //   decoration: BoxDecoration(
//             //     color: AppColors.primaryColor2,
//             //     shape: BoxShape.circle,
//             //   ),
//             //   // child: const Text(""),
//             // ),
//             // const SizedBox(height: 8),
//             Container(
//               height: 5,
//               width: 5,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor2,
//                 shape: BoxShape.circle,
//               ),
//               // child: const Text(""),
//             ),
//             const SizedBox(height: 8),
//             Icon(
//               FontAwesomeIcons.mapMarkerAlt,
//               size: 25,
//               color: AppColors.primaryColor2,
//             ),
//           ],
//         ),
//         // const SizedBox(width: 8),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.78,
//           // decoration: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(10),
//           //   boxShadow: kElevationToShadow[4],
//           // ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 picklocation + '\n',
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(
//                   fontFamily: "regular",
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 droplocation + '\n',
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(
//                   fontFamily: "regular",
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
