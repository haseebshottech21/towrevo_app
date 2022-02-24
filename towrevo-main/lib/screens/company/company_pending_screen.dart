import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/map_distance_screen.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/Loaders/no_user.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/profile_image_circle.dart';
import 'package:towrevo/widgets/show_snackbar.dart';
import '../../utilities.dart';

class CompanyPendingList extends StatefulWidget {
  const CompanyPendingList({Key? key}) : super(key: key);

  @override
  _CompanyPendingListState createState() => _CompanyPendingListState();
}

class _CompanyPendingListState extends State<CompanyPendingList> {
  // @override
  // void initState() {
  //   super.initState();

  //   if (text.length > 50) {
  //     firstHalf = text.substring(0, 50);
  //     secondHalf = text.substring(50, text.length);
  //   } else {
  //     firstHalf = text;
  //     secondHalf = "";
  //   }

  //   if (descText.length > 50) {
  //     setState(() {
  //       textExpand = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);
    print('listen success');
    return Stack(
      children: [
        const FullBackgroundImage(),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Pending',
              //       style: TextStyle(
              //         fontSize: 22.0,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
              (provider.isLoading || provider.requestServiceList.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: provider.isLoading
                            ? circularProgress()
                            : noDataImage(
                                context,
                                'Waiting Jobs',
                                'assets/images/towing.png',
                              ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: provider.requestServiceList.length,
                        itemBuilder: (context, index) {
                          return FadeInUp(
                            from: 30,
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 10,
                                  top: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 9,
                                          child: Column(
                                            children: [
                                              // Container(
                                              //   alignment: Alignment.centerLeft,
                                              //   child: Text('acas'),
                                              // ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  provider
                                                      .requestServiceList[index]
                                                      .name,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        provider.requestServiceList[index].image
                                                .isNotEmpty
                                            ? profileImageCircle(
                                                context,
                                                Utilities.imageBaseUrl +
                                                    provider
                                                        .requestServiceList[
                                                            index]
                                                        .image)
                                            : const Flexible(
                                                fit: FlexFit.tight,
                                                flex: 1,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  child: Icon(
                                                    Icons.home_work_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text(
                                          provider.requestServiceList[index]
                                              .address,
                                          textAlign: TextAlign.start,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                MapDistanceScreen.routeName,
                                                arguments: LatLng(
                                                    double.parse(provider
                                                        .requestServiceList[
                                                            index]
                                                        .latitude),
                                                    double.parse(
                                                      provider
                                                          .requestServiceList[
                                                              index]
                                                          .longitude,
                                                    )));
                                          },
                                          child: const Text('Get Directions'),
                                        ),
                                        SizedBox(
                                          width: 135,
                                          child: Row(
                                            children: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                ),
                                                onPressed: () async {
                                                  await CompanyHomeScreenViewModel()
                                                      .acceptDeclineOrDone(
                                                    '1',
                                                    provider
                                                        .requestServiceList[
                                                            index]
                                                        .id,
                                                    context,
                                                    notificationId: provider
                                                        .requestServiceList[
                                                            index]
                                                        .notificationId,
                                                  );
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
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                ),
                                                onPressed: () async {
                                                  await CompanyHomeScreenViewModel()
                                                      .acceptDeclineOrDone(
                                                          '2',
                                                          provider
                                                              .requestServiceList[
                                                                  index]
                                                              .id,
                                                          context,
                                                          notificationId: provider
                                                              .requestServiceList[
                                                                  index]
                                                              .notificationId);
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
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await setupInteracted();
      await setUpRequestNotification();
      await checkPayment();
      await getData();
    });

    super.initState();
  }

  Future<void> getData() async {
    print('in data');
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await provider.getRequests();
  }

  Future<void> checkPayment() async {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
            .paymentStatusCheck(context);
  }

  Future<void> setUpRequestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> setupInteracted() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('yes');
    print(initialMessage?.data.toString());
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      // Navigator.pushNamed(context, RequestScreen.routeName,);
      getData();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message);
      if (message.data['screen'] == 'decline_from_user') {
        // Fluttertoast.showToast(msg: 'Time Delayed Request Decline');
        showSnackBar(
          context: context,
          title: 'Time Delayed Request Decline',
          labelText: '',
          onPress: () {},
        );
        getData();
      }
      if (message.data['screen'] == 'decline_from_company') {
        // Fluttertoast.showToast(msg: 'Decline From Company');
        showSnackBar(
          context: context,
          title: 'Decline From Company',
          labelText: '',
          onPress: () {},
        );
        getData();
      }
      if (message.data['screen'] == 'request') {
        // Fluttertoast.showToast(msg: 'User Send Request');
        showSnackBar(
          context: context,
          title: 'User Send Request',
          labelText: '',
          onPress: () {},
        );
        getData();
        // Navigator.pushNamed(context, RequestScreen.routeName,);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    print(message);
    print(message.data);
    if (message.data['screen'] == 'decline_from_user') {
      // Fluttertoast.showToast(msg: 'Time Delayed Request Decline');
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
    if (message.data['screen'] == 'decline_from_company') {
      // Fluttertoast.showToast(msg: 'Decline From Company');
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
    if (message.data['screen'] == 'request') {
      // Fluttertoast.showToast(msg: 'User Send Request');
      showSnackBar(
        context: context,
        title: 'User Send Request',
        labelText: '',
        onPress: () {},
      );
      getData();
      // Navigator.pushNamed(context, RequestScreen.routeName,);
    }
  }
}
