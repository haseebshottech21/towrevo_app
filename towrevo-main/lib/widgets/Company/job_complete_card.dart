import 'package:flutter/material.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';

class JobCompleteCard extends StatelessWidget {
  final String userName;
  final String userDistance;
  final String serviceType;
  final String pickLocation;
  final String dropLocation;
  final Widget profileImage;
  final void Function()? completeOnPressed;
  const JobCompleteCard({
    required this.userName,
    required this.userDistance,
    required this.serviceType,
    required this.dropLocation,
    required this.pickLocation,
    required this.profileImage,
    required this.completeOnPressed,
    Key? key,
  }) : super(key: key);

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
                    userName,
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
                    '($userDistance mi)',
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
                profileImage,
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
                  color: AppColors.primaryColor2.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryColor, width: 1.5),
                ),
                child: Text(
                  serviceType,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            timelineRow(pickLocation, 'Pick Up'),
            timelineRow(dropLocation, 'Drop Of'),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution...',
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // setState(() {
                            //   textExpand = !textExpand;
                            // });
                          },
                          child: const Text(
                            // textExpand == false ? "show more" : "show less",
                            'show less',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: const StadiumBorder(),
                    primary: Colors.blue[50],
                  ),
                  onPressed: () {
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
                Image.asset(
                  "assets/images/spinner.gif",
                  height: 30.0,
                  width: 30.0,
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
                  onPressed: completeOnPressed,
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
    );
  }

  Widget timelineRow(String title, String point) {
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
              Icon(
                Icons.location_pin,
                color: AppColors.primaryColor2,
                size: 30,
              ),
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
                point,
                style: const TextStyle(
                  fontFamily: "regular",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title + '\n',
                style: const TextStyle(
                  fontFamily: "regular",
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  // Widget timelineLastRow(String title, String point) {
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
  //               point,
  //               style: const TextStyle(
  //                 fontFamily: "regular",
  //                 fontSize: 11,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               title + '\n',
  //               style: const TextStyle(
  //                 fontFamily: "regular",
  //                 fontSize: 14,
  //                 color: Colors.black54,
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
