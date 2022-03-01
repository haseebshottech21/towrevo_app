import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/screens/company/distance_screen.dart';
import 'package:towrevo/screens/map_distance_screen.dart';

class AcceptDeclineCardItem extends StatefulWidget {
  final String userName;
  final String userDistance;
  final String serviceType;
  final String pickLocation;
  final String dropLocation;
  final Widget profileImage;
  final String probText;
  final LatLng pickuplatLng;
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
    required this.pickuplatLng,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        width: MediaQuery.of(context).size.width,
        // height: 50,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[6],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '(${widget.userDistance} mi)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // provider.requestServiceList[index].image.isNotEmpty
                //     ? profileImageCircle(
                //         context,
                //         Utilities.imageBaseUrl +
                //             provider.requestServiceList[index].image,
                //       )
                //     :
                const Spacer(),
                // const CircleAvatar(
                //   backgroundColor: Colors.black,
                //   child: Icon(
                //     Icons.home_work_outlined,
                //     color: Colors.white,
                //   ),
                // ),
                widget.profileImage,
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  widget.serviceType,
                  // style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            timelineRow(widget.pickLocation),
            timelineLastRow(widget.dropLocation),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                  style: const TextStyle(color: Colors.blue),
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: const StadiumBorder(),
                    primary: Colors.blue[50],
                  ),
                  onPressed: () {
                    print('yes in location screen');
                    Navigator.of(context).pushNamed(
                      DistanceScreen.routeName,
                      arguments: widget.pickuplatLng,
                    );
                    // Navigator.of(context).pushNamed(
                    //   MapDistanceScreen.routeName,
                    //   arguments: LatLng(
                    //     double.parse(provider
                    //         .requestServiceList[index].latitude),
                    //     double.parse(
                    //       provider
                    //           .requestServiceList[index].longitude,
                    //     ),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Get Directions',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    children: [
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
                      const SizedBox(
                        width: 5,
                      ),
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
                    ],
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

Widget timelineRow(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_pin,
              color: AppColors.primaryColor2,
              size: 30,
            ),
            const SizedBox(height: 5),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primaryColor2,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primaryColor2,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primaryColor2,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title + '\n',
              style: const TextStyle(
                fontFamily: "regular",
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget timelineLastRow(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_pin,
              color: AppColors.primaryColor2,
              size: 30,
            ),
            Container(
              width: 3,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title + '\n',
              style: const TextStyle(
                fontFamily: "regular",
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
