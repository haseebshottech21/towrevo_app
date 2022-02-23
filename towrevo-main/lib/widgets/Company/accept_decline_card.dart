import 'package:flutter/material.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';

class AcceptDeclineCardItem extends StatelessWidget {
  const AcceptDeclineCardItem({Key? key}) : super(key: key);

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
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'ABC Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '(0.0 mi)',
                    style: TextStyle(
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
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.home_work_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            timelineRow(
              "1600 Amphirew Pkwy, Mountaon View, California, 94560, United Stated",
              "",
            ),
            timelineLastRow(
              "1600 Amphirew Pkwy, Mountaon View, California, 94560, United Stated",
              "",
            ),
            const SizedBox(height: 5),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           descText,
            //           textAlign: TextAlign.start,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 setState(() {
            //                   textExpand = !textExpand;
            //                 });
            //               },
            //               child: Text(
            //                 textExpand == false ? "show more" : "show less",
            //                 style: const TextStyle(color: Colors.blue),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // padding: EdgeInsets.s,
                          primary: Colors.green[50],
                        ),
                        onPressed: () async {
                          // await CompanyHomeScreenViewModel()
                          //     .acceptDeclineOrDone(
                          //   '1',
                          //   provider.requestServiceList[index].id,
                          //   context,
                          //   notificationId: provider
                          //       .requestServiceList[index]
                          //       .notificationId,
                          // );
                        },
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
                          primary: Colors.red[50],
                        ),
                        onPressed: () async {
                          // await CompanyHomeScreenViewModel()
                          //     .acceptDeclineOrDone(
                          //         '2',
                          //         provider
                          //             .requestServiceList[index].id,
                          //         context,
                          //         notificationId: provider
                          //             .requestServiceList[index]
                          //             .notificationId);
                        },
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

Widget timelineRow(String title, String subTile) {
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
            Text('${title}\n',
                style: const TextStyle(
                    fontFamily: "regular",
                    fontSize: 14,
                    color: Colors.black54)),
          ],
        ),
      ),
    ],
  );
}

Widget timelineLastRow(String title, String subTile) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${title}\n ${subTile}',
                style: TextStyle(
                    fontFamily: "regular",
                    fontSize: 14,
                    color: Colors.black54)),
          ],
        ),
      ),
    ],
  );
}
