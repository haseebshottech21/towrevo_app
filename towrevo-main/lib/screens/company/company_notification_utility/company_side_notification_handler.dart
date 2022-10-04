import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:towrevo/widgets/show_snackbar.dart';

class CompanySideNotificationHandler {
  Future<void> notificationHandler(
    BuildContext context,
    Function getData,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  ) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      getData();
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        _handleMessage(event, context, getData);
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        onMessageListen(message, context, getData);
        // Future.delayed(const Duration(seconds: 1)).then(
        //   (value) {
        //   },
        // );
      },
    );
  }

  onMessageListen(
    RemoteMessage message,
    BuildContext context,
    Function getData,
  ) {
    // if (message != null) {
    // print("it will work");

    if (message.data['screen'] == 'decline_from_user') {
      showSnackBar(
        context: context,
        title: 'Missed Customer Request',
        labelText: 'Ok',
        seconds: 10,
        onPress: () {},
      );
      getData();
    }

    if (message.data['screen'] == 'request') {
      play();
      showSnackBar(
        context: context,
        title: 'User Send Request',
        labelText: '',
        onPress: () {},
      );
      getData();
    }
    // }
  }

  static AudioPlayer player = AudioPlayer();

  void play() async {
    await player.setLoopMode(LoopMode.all);
    await player.setAsset('assets/sounds/sound_new.mp3');

    player.play();

    await Future.delayed(const Duration(seconds: 15)).then(
      (value) {
        player.stop();
      },
    );
  }

  void stop() async {
    player.stop();
  }

  void _handleMessage(
    RemoteMessage message,
    BuildContext context,
    Function getData,
  ) async {
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
      // clearNoti();
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
