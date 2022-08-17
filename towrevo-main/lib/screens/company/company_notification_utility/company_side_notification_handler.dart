import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:towrevo/widgets/show_snackbar.dart';

class CompanySideNotificationHandler {
  Future<void> notificationHandler(
    BuildContext context,
    Function getData,
  ) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // print(initialMessage);

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
          // logic();
          playLoopedNotification();
          showSnackBar(
            context: context,
            title: 'User Send Request',
            labelText: '',
            onPress: () {},
          );
          getData();
        }
      },
    );
  }

  static AudioCache? musicCache;
  static AudioPlayer? instance;

  void playLoopedNotification() async {
    musicCache = AudioCache(prefix: "assets/sounds/");
    instance = await musicCache!.loop("sound_new.mp3");
    // await instance.setVolume(0.5); you can even set the volume

    await Future.delayed(const Duration(seconds: 15)).then((value) {
      stopNotification();
    });
  }

  void stopNotification() {
    if (instance != null) {
      instance!.stop();
    }
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
