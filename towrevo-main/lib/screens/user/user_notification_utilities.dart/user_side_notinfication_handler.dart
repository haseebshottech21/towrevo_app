import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/user/user_home_screen.dart';
import 'package:towrevo/widgets/User/user_accept_bottom_sheet.dart';
import '../../../view_model/user_home_screen_view_model.dart';
import '../../../widgets/User/user_rating_dialogbox.dart';
import '../../../widgets/show_snackbar.dart';

class UserSideNotificationHandler {
  Future<void> notificationHandler(BuildContext context) async {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);

    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(event, context);
    });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) async {
        if (message!.data['screen'] == 'accept') {
          showSnackBar(
            context: context,
            title: 'Request Accept From Company',
            labelText: '',
            onPress: () {},
          ).then((value) {
            provider.bottomSheetData = {
              'requestedId': message.data['id'],
              'requested': true,
            };
            Navigator.of(context).pushNamedAndRemoveUntil(
              UsersHomeScreen.routeName,
              (route) => false,
            );
          });
        }
        if (message.data['screen'] == 'decline_from_company') {
          showSnackBar(
            context: context,
            title: 'Decline From Company',
            labelText: 'Ok',
            onPress: () {},
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
              UsersHomeScreen.routeName, (route) => false);
        }
        if (message.data['screen'] == 'request') {
          showSnackBar(
            context: context,
            title: 'User Send Request',
            labelText: 'Ok',
            onPress: () {},
          );
        }
        if (message.data['screen'] == 'complete') {
          showSnackBar(
            context: context,
            title: 'Job Complete Successfully',
            labelText: '',
            onPress: () {},
          ).then(
            (value) {
              provider.rating = 0;

              provider.ratingData = {
                'requestedId': message.data['id'],
                'requested': true,
              };
              provider.bottomSheetData = {
                'requestedId': '',
                'requested': false,
              };
              Navigator.of(context).pushNamedAndRemoveUntil(
                UsersHomeScreen.routeName,
                (route) => false,
              );
            },
          );
        }
      },
    );
  }

  void _handleMessage(RemoteMessage message, BuildContext context) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);

    if (message.data['screen'] == 'decline_from_user') {
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
    }
    if (message.data['screen'] == 'decline_from_company') {
      showSnackBar(
        context: context,
        title: 'Decline From Company',
        labelText: '',
        onPress: () {},
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UsersHomeScreen.routeName, (route) => false);
    }
    if (message.data['screen'] == 'request') {
      showSnackBar(
        context: context,
        title: 'User Send Request',
        labelText: '',
        onPress: () {},
      );
    }
    if (message.data['screen'] == 'accept') {
      showSnackBar(
        context: context,
        title: 'Accepted From Company',
        labelText: '',
        onPress: () {},
      ).then(
        (value) {
          provider.bottomSheetData = {
            'requestedId': message.data['id'],
            'requested': true,
          };
          Navigator.of(context).pushNamedAndRemoveUntil(
              UsersHomeScreen.routeName, (route) => false);
        },
      );
    }
    if (message.data['screen'] == 'complete') {
      showSnackBar(
        context: context,
        title: 'Job Complete Successfully',
        labelText: '',
        onPress: () {},
      ).then(
        (value) {
          provider.rating = 0;

          provider.ratingData = {
            'requestedId': message.data['id'],
            'requested': true,
          };
          provider.bottomSheetData = {
            'requestedId': '',
            'requested': false,
          };

          Navigator.of(context).pushNamedAndRemoveUntil(
            UsersHomeScreen.routeName,
            (route) => false,
          );
        },
      );
    }
  }

  Future<void> checkRatingStatus(BuildContext context) async {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);

    if (provider.bottomSheetData['requested']) {
      Future.delayed(Duration.zero).then(
        (value) async {
          Map<String, String> map = await provider.getRequestStatusData(
              provider.bottomSheetData['requestedId'].toString());
          if (map.isNotEmpty) {
            await openBottomSheet(
              context,
              map['companyName'].toString(),
            );
          }
        },
      ).then(
        (value) {
          provider.bottomSheetData = {
            'requestedId': '',
            'requested': false,
          };
        },
      );
    }

    if (provider.ratingData['requested']) {
      Future.delayed(Duration.zero).then(
        (value) async {
          Map<String, String> map = await provider.getRequestStatusData(
            provider.ratingData['requestedId'].toString(),
          );
          await showDialog(
            context: context,
            builder: (_) {
              return UserRatingDialog(
                reqId: provider.ratingData['requestedId'].toString(),
                companyName: map['companyName'].toString(),
                serviceName: map['serviceName'].toString(),
              );
            },
          ).then((value) {
            provider.ratingData = {
              'requestedId': '',
              'requested': false,
            };
          });
        },
      );
    }
  }
}
