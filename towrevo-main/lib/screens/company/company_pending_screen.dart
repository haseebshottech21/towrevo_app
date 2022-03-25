import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          // physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
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
                          return FadeInUp(
                            from: 30,
                            child: AcceptDeclineCardItem(
                              serviceRequestModel:
                                  provider.requestServiceList[index],
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
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // print(initialMessage?.data.toString());

    if (initialMessage != null) {
      getData();
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message);
      if (message.data['screen'] == 'decline_from_user') {
        showSnackBar(
          context: context,
          title: 'Time Delayed Request Decline',
          labelText: '',
          onPress: () {},
        );
        getData();
      }

      if (message.data['screen'] == 'request') {
        await playSound();

        showSnackBar(
          context: context,
          title: 'User Send Request',
          labelText: '',
          onPress: () {},
        );
        getData();
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
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
    if (message.data['screen'] == 'decline_from_company') {
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
    if (message.data['screen'] == 'request') {
      showSnackBar(
        context: context,
        title: 'User Send Request',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
  }
}
