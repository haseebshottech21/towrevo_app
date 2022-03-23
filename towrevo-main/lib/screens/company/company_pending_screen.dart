import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

class CompanyPendingScreen extends StatefulWidget {
  const CompanyPendingScreen({Key? key}) : super(key: key);

  @override
  _CompanyPendingScreenState createState() => _CompanyPendingScreenState();
}

class _CompanyPendingScreenState extends State<CompanyPendingScreen> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);

    return Stack(
      children: [
        const FullBackgroundImage(),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // AcceptDeclineCardItem(
              //   userName: 'Name',
              //   userDistance: '0.0',
              //   // profileImage: const CircleAvatar(
              //   //   backgroundColor: Colors.black,
              //   //   child: Icon(
              //   //     Icons.home_work_outlined,
              //   //     color: Colors.white,
              //   //   ),
              //   // ),
              //   profileImage: Container(
              //     height: 50,
              //     width: 50,
              //     decoration: BoxDecoration(
              //       boxShadow: kElevationToShadow[2],
              //       color: AppColors.primaryColor,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: const Icon(
              //       Icons.person,
              //       size: 30,
              //       color: Colors.white,
              //     ),
              //   ),
              //   serviceType: 'CAR',
              //   probText:
              //       'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
              //   pickLocation:
              //       'Business Avenue, PECHS, Karachi, Sindh, Pakistan',
              //   dropLocation:
              //       'Business Avenue, PECHS, Karachi, Sindh, Pakistan',
              //   acceptOnPressed: () async {},
              //   declineOnPressed: () async {},
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
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.requestServiceList.length,
                        itemBuilder: (context, index) {
                          bool isExpanded = false;
                          return FadeInUp(
                            from: 30,
                            child: AcceptDeclineCardItem(
                              userName: provider.requestServiceList[index].name,
                              userDistance: provider.requestServiceList[index]
                                      .destAddress.isEmpty
                                  ? provider.requestServiceList[index].distance
                                  : provider
                                      .requestServiceList[index].totalDistance,
                              profileImage: provider.requestServiceList[index]
                                      .image.isNotEmpty
                                  ? profileImageSquare(
                                      context,
                                      Utilities.imageBaseUrl +
                                          provider
                                              .requestServiceList[index].image,
                                    )
                                  : const EmptyProfile(),
                              serviceType: provider
                                  .requestServiceList[index].serviceName,
                              pickLocation:
                                  provider.requestServiceList[index].address,
                              dropLocation: provider
                                  .requestServiceList[index].destAddress,
                              // showMoreTap: () {
                              //   setState(() {
                              //     isExpanded = !isExpanded;
                              //   });
                              // },
                              probText: provider
                                  .requestServiceList[index].description,
                              acceptOnPressed: () async {
                                await CompanyHomeScreenViewModel()
                                    .acceptDeclineOrDone(
                                  '1',
                                  provider.requestServiceList[index].id,
                                  context,
                                  notificationId: provider
                                      .requestServiceList[index].notificationId,
                                );
                              },
                              declineOnPressed: () async {
                                await CompanyHomeScreenViewModel()
                                    .acceptDeclineOrDone(
                                  '2',
                                  provider.requestServiceList[index].id,
                                  context,
                                  notificationId: provider
                                      .requestServiceList[index].notificationId,
                                );
                              },
                              // pickuplatLng: LatLng(
                              //   double.parse(provider
                              //       .requestServiceList[index].latitude),
                              //   double.parse(provider
                              //       .requestServiceList[index].longitude),
                              // ),
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
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
      // if (message.data['screen'] == 'decline_from_company') {
      //   // Fluttertoast.showToast(msg: 'Decline From Company');
      //   showSnackBar(
      //     context: context,
      //     title: 'Decline From Company',
      //     labelText: '',
      //     onPress: () {},
      //   );
      //   getData();
      // }
      if (message.data['screen'] == 'request') {
        await playSound();
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

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  playSound() async {
    final file = await audioCache.loadAsFile('sounds/sound_new.mp3');
    final bytes = await file.readAsBytes();
    audioCache.playBytes(bytes);
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
