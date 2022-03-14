import 'package:flutter/material.dart';
import 'package:towrevo/utitlites/towrevo_appcolor.dart';

class AcceptDeclineCardItem extends StatefulWidget {
  final String userName;
  final String userDistance;
  final String serviceType;
  final String pickLocation;
  final String dropLocation;
  final Widget profileImage;
  final String probText;
  // final LatLng pickuplatLng;
  final void Function()? acceptOnPressed;
  final void Function()? declineOnPressed;
  final bool isExpanded;

  const AcceptDeclineCardItem({
    required this.userName,
    required this.userDistance,
    required this.serviceType,
    required this.dropLocation,
    required this.pickLocation,
    required this.profileImage,
    required this.probText,
    required this.acceptOnPressed,
    required this.declineOnPressed,
    // required this.pickuplatLng,
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

    if (widget.probText.length > 50) {
      firstHalf = widget.probText.substring(0, 50);
      secondHalf = widget.probText.substring(50, widget.probText.length);
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
                            widget.userDistance +
                                ' ' +
                                (widget.dropLocation.isEmpty
                                    ? 'miles away'
                                    : 'total distance'),
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
                      fontSize: 12,
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
                        // onPressed: anim == true
                        //     ? null
                        //     : () {
                        //         setState(() {
                        //           animHeight = 140;
                        //           animHeightmain = animHeightmain + animHeight;
                        //           anim = true;
                        //         });
                        //       },
                        onPressed: anim == true
                            ? null
                            : () {
                                setState(() {
                                  widget.dropLocation.isEmpty
                                      ? animHeight = 150
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
                      Row(
                        children: [
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     // padding: EdgeInsets.zero,
                          //     shape: const StadiumBorder(),
                          //     primary: Colors.white,
                          //     side: const BorderSide(color: Colors.red),
                          //   ),
                          //   onPressed: widget.declineOnPressed,
                          //   child: const Text(
                          //     'Decline',
                          //     style: TextStyle(
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // padding: EdgeInsets.zero,
                              shape: const StadiumBorder(),
                              primary: Colors.red[50],
                            ),
                            onPressed: widget.declineOnPressed,
                            child: const Text(
                              'Decline',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     // padding: EdgeInsets.zero,
                          //     shape: const StadiumBorder(),
                          //     primary: Colors.green,
                          //     side: const BorderSide(color: Colors.green),
                          //   ),
                          //   onPressed: widget.acceptOnPressed,
                          //   child: const Text(
                          //     'Accept',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              // padding: EdgeInsets.s,
                              primary: Colors.green[50],
                            ),
                            onPressed: widget.acceptOnPressed,
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
    //               color: Colors.blue.withOpacity(0.2),
    //               borderRadius: BorderRadius.circular(20),
    //               border: Border.all(color: Colors.black),
    //             ),
    //             child: Text(
    //               widget.serviceType,
    //               // style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         timelineRow(widget.pickLocation),
    //         timelineLastRow(widget.dropLocation),
    //         const SizedBox(height: 5),
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
    //         const SizedBox(height: 10),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 padding: const EdgeInsets.symmetric(horizontal: 12),
    //                 shape: const StadiumBorder(),
    //                 primary: Colors.blue[50],
    //               ),
    //               onPressed: () {
    //                 print('yes in location screen');
    //                 Navigator.of(context).pushNamed(
    //                   DistanceScreen.routeName,
    //                   arguments: widget.pickuplatLng,
    //                 );
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
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.42,
    //               child: Row(
    //                 children: [
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       shape: const StadiumBorder(),
    //                       // padding: EdgeInsets.s,
    //                       primary: Colors.green[50],
    //                     ),
    //                     onPressed: widget.acceptOnPressed,
    //                     child: const Text(
    //                       'Accept',
    //                       style: TextStyle(
    //                         color: Colors.green,
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     width: 5,
    //                   ),
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       // padding: EdgeInsets.zero,
    //                       shape: const StadiumBorder(),
    //                       primary: Colors.red[50],
    //                     ),
    //                     onPressed: widget.declineOnPressed,
    //                     child: const Text(
    //                       'Decline',
    //                       style: TextStyle(
    //                         color: Colors.red,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             )
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
//             const SizedBox(height: 5),
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor2,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor2,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor2,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(height: 5),
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

// Widget timelineLastRow(String title) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: <Widget>[
//       Expanded(
//         flex: 1,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.location_pin,
//               color: AppColors.primaryColor2,
//               size: 30,
//             ),
//             Container(
//               width: 3,
//               height: 20,
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//                 shape: BoxShape.rectangle,
//               ),
//             ),
//           ],
//         ),
//       ),
//       Expanded(
//         flex: 9,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
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
