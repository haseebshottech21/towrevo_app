import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:towrevo/widgets/show_snackbar.dart';

class CompanySideNotificationHandler {
  Future<void> notificationHandler(
      BuildContext context, Function getData) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      getData();
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(event, context, getData);
    });
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
          await playSound();
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

  // bool close = false;

  // closeAudio() {
  //   // print('ok');
  //   close = true;
  //   // advancedPlayer.stop();
  //   // // audioCache.clearAll();
  //   // advancedPlayer.stop();
  // }

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  playSound() async {
    advancedPlayer = await audioCache.loop('sounds/sound_new.mp3');
    // await advancedPlayer.setUrl(file.toString());
    // final bytes = await file.readAsBytes();
    // audioCache.playBytes(bytes, loop: true);

    Future.delayed(const Duration(seconds: 15)).then((value) {
      advancedPlayer.stop();
    });
  }

  void _handleMessage(
      RemoteMessage message, BuildContext context, Function getData) {
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
